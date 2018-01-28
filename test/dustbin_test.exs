defmodule DustbinTest do
  use ExUnit.Case
  doctest Dustbin

  test "greets the world" do
    assert Dustbin.hello() == :world
  end
end
