defmodule Dustbin.APIWeb.CollectionScheduleControllerTest do
  use Dustbin.APIWeb.ConnCase

  test "GET /collects/:id returns a specific existing collect", %{conn: conn} do
    collect = insert(:collection_schedule)

    response = conn
    |> get(collection_schedule_path(conn, :show, collect))
    |> json_response(200)
    |> Map.get("collect")

    assert response["id"] == collect.id
    assert response["location"]["id"] == collect.location.id
  end

  test "GET /collects/:id returns a specific collect in the corresposding supported locale", %{conn: conn} do
    collect = insert(:collection_schedule)

    response = conn
    |> put_req_header("accept-language", "fr")
    |> get(collection_schedule_path(conn, :show, collect))
    |> json_response(200)
    |> Map.get("collect")

    assert response["name"] == "Ordures et encombrants"
    assert response["details"] == "Encombrants: tapis et toiles de piscine roulés, mobilier"
  end

  test "GET /collects/:id responds with 404 when given an unexistent :id", %{conn: conn} do
    assert(
      conn
      |> get(collection_schedule_path(conn, :show, "foo"))
      |> response(404)
    )
  end
end