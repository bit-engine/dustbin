defmodule DataTest do
  use Dustbin.Data.Case

  test "supported_locations/0 returns all the existent locations" do
    result = Dustbin.Data.supported_locations
    assert length(result) == 1
  end
end
