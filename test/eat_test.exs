defmodule EatTest do
  use ExUnit.Case
  doctest Eat

  test "greets the world" do
    assert Eat.hello() == :world
  end
end
