defmodule Dustbin.API.Schedules do
  @moduledoc """
  The Schedules context.
  """
  import Ecto.Query, warn: false
  alias Dustbin.Data.Repo
  alias Dustbin.Data.CollectionSchedule
  alias Dustbin.Data.Location

  @doc """
  Get a collection schedule by id (uuid)
  """
  def get_collection_schedule(<<_::64, ?-, _::32, ?-, _::32, ?-, _::32, ?-, _::96>> = id) do
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

  @doc """
  Get a list of collection schedules for a specific location.
  By default only the *upcoming* collection schedules will be retrieved,
  unless indicated to retrive them all via the filter query string
  """

  def get_collection_schedules_for_location(<<_::64, ?-, _::32, ?-, _::32, ?-, _::32, ?-, _::96>> = id, %{"filter" => filter}) do
    case filter do
      "all" ->
        query = from sch in CollectionSchedule,
          preload: [:location],
          where: sch.location_id == ^id
        {:ok, Repo.all(query)}
      filter ->
        {:error, {:bad_request, "Unknown filter #{filter} given"}}
    end
  end 

  def get_collection_schedules_for_location(<<_::64, ?-, _::32, ?-, _::32, ?-, _::32, ?-, _::96>> = id, _query) do
    query = from sch in CollectionSchedule,
      preload: [:location],
      join: loc in Location, where: loc.id == sch.location_id 
    
    query = from [c, l] in query,
      where: c.location_id == ^id and c.scheduled_date >= fragment("(timezone(?, now()))::date", l.timezone)

    {:ok, Repo.all(query)} 
  end

  def get_collection_schedules_for_location(_, _), do: {:error, :not_found}
end
