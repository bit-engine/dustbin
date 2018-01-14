defmodule Dustbin.Data.Seed do
  @base_path "seed_data" 
  @locations [
    %{
      slug: "chambly",
      display_name: "Chambly, Canada",
      timezone: "America/Montreal",
      collects_path: "chambly"
    }
  ]

  alias Dustbin.Data.{
    Location,
    CollectionSchedule,
    Repo
  }

  def run() do
    Enum.each(@locations, fn location ->
      location_struct = struct(Location, Map.take(location, ~w(slug display_name timezone)a)) 
      result = Repo.insert! location_struct
      path = path(Mix.env, location.collects_path)
      
      case File.ls(path) do
        {:ok, files} ->
          Enum.reduce(files, [], fn(file, acc) -> [File.read!("#{path}/#{file}") |> Poison.decode! | acc] end)
          |> List.flatten
          |> insert_collects(result.id)
        {:error, _} ->
          IO.puts "Error seed path"
      end
    end)
  end

  defp insert_collects([collect | collects], location_id) do
    insert(collect, location_id)
    insert_collects(collects, location_id)
  end

  defp insert_collects([], _) do
  end

  defp insert(collect = %{"name" => name, "occurrences" => occurrences}, location_id) do
    Enum.each(occurrences, fn occurrence ->
      Repo.insert! %CollectionSchedule{
        name: name,
        details: Map.get(collect, "details"),
        scheduled_date: Ecto.Date.cast!(occurrence),
        location_id: location_id
      }
    end)
  end

  defp path(:prod, path) do
    "#{:code.priv_dir(:data)}/#{@base_path}/#{path}"
  end

  defp path(_, path), do: "#{__DIR__}/#{@base_path}/#{path}"
end

Dustbin.Data.Seed.run()
