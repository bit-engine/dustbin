defmodule Dustbin.API.Schedules do
  @moduledoc """
  The Schedules context.
  """

  import Ecto.Query, warn: false
  alias Dustbin.Data.Repo
  alias Dustbin.Data.CollectionSchedule

  def get_collection_schedule(id = <<_::64, ?-, _::32, ?-, _::32, ?-, _::32, ?-, _::96>>) do
    query =
      CollectionSchedule
      |> preload(:location)
      |> where(id: ^id)

    case Repo.one query do
      %CollectionSchedule{} = collect -> {:ok, collect}
      nil ->  {:error, :not_found}
    end
  end
  
  def get_collection_schedule(_), do: {:error, :not_found}
end

  
