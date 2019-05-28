defmodule ModuleLab5Test do
  use ExUnit.Case
  doctest ModuleLab5

  test "greets the world" do
    assert ModuleLab5.hello() == :world
  end
end
