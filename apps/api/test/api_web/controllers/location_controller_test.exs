defmodule Dustbin.APIWeb.LocationControllerTest do
  use Dustbin.APIWeb.ConnCase
  
  test "GET /locations/:id/collects returns all the upcoming collection schedules for a specific location", %{conn: conn} do
    location = insert(:location)
    collects_sequence(location) # 2 upcoming, 1 past
    
    response = conn
    |> get(location_collects_path(conn, :index, location))
    |> json_response(200)
    |> Map.get("collects")

    assert length(response) == 2
    
    Enum.each(response, fn %{"location" => %{"id" => id}} ->
      assert id == location.id
    end)
  end

  test "GET /locations/:id/collects returns all collection schedules when applying all as filter", %{conn: conn} do
    location = insert(:location)
    collects_sequence(location, [upcoming: 5, past: 1])

    collects_sequence(insert(:location))

    response = conn
    |> get(location_collects_path(conn, :index, location, filter: "all"))
    |> json_response(200)
    |> Map.get("collects")

    assert length(response) == 6
  end

  test "GET /locations/:id/collects returns bad request response when passing an unknown filter", %{conn: conn} do
    response = conn
    |> get(location_collects_path(conn, :index, insert(:location), filter: "foo"))
    |> json_response(400)

    assert response["error"] == "Bad Request"
    assert response["details"] == "Unknown filter foo given" 
  end

  test "GET /locations/:id/collects returns not found when an unexisting location is given", %{conn: conn} do
    assert(
      conn
      |> get(location_collects_path(conn, :index, "foo", filter: "all"))
      |> response(404)
    )
  end

  test "GET /locations/:id/collects with a supported locale applies the correct translation to name and details", %{conn: conn} do
    location = insert(:location)
    collects_sequence(location, [upcoming: 1, past: 1])

    response = conn
    |> put_req_header("accept-language", "fr")
    |> get(location_collects_path(conn, :index, location))
    |> json_response(200)
    |> Map.get("collects")

    [head|_] = response
    assert head["name"] == "Ordures et encombrants"
    assert head["details"] == "Encombrants: tapis et toiles de piscine roulés, mobilier"

  
    response = conn
    |> put_req_header("accept-language", "en")
    |> get(location_collects_path(conn, :index, location))
    |> json_response(200)
    |> Map.get("collects")


    [head|_] = response
    assert head["name"] == "Garbage and bulky waste"
    assert head["details"] == "Bulky waste: rugs and rolled pool mats, furniture"
  end

  test "GET /locations/:id/collects with an unknown locale or no locale at all, defaults to en_US", %{conn: conn} do 
    location = insert(:location)
    collects_sequence(location, [upcoming: 1, past: 1])

    response = conn
    |> get(location_collects_path(conn, :index, location))
    |> json_response(200)
    |> Map.get("collects")


    [head|_] = response
    assert head["name"] == "Garbage and bulky waste"
    assert head["details"] == "Bulky waste: rugs and rolled pool mats, furniture"
  end
end
