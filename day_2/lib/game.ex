defmodule Game do
  @enforce_keys [:id]
  defstruct id: nil, sets: [], minimum_color_amount: nil

  @type t() :: %__MODULE__{
          id: integer(),
          sets: list(),
          minimum_color_amount: map()
        }

  def calculate_set_power(%Game{minimum_color_amount: minimum_color_amount}) do
    minimum_color_amount |> Map.values() |> Enum.reduce(&(&1 * &2))
  end

  def define_minimum_color_amount(%Game{sets: sets} = game) do
    game |> Map.put(:minimum_color_amount, sets |> Enum.reduce(%{}, &accumulate_max_amount/2))
  end

  defp accumulate_max_amount(set, map) do
    set
    |> Enum.reduce(map, fn {color, amount}, map ->
      map |> Map.update(color, amount, &max(&1, amount))
    end)
  end
end
