defmodule Day2_2 do
  def main(asset) do
    read_input("assets/#{asset}.txt")
    |> Enum.map(&parse_input_line/1)
    |> Enum.map(&Game.define_minimum_color_amount/1)
    |> Enum.map(&Game.calculate_set_power/1)
    |> Enum.reduce(&(&1 + &2))
  end

  defp read_input(file_path) do
    File.read!(file_path)
    |> String.split("\n")
  end

  defp parse_input_line(string) do
    results = Regex.run(~r/Game (\d+): (.+)/, string) |> tl()
    id = results |> List.first() |> String.to_integer()
    sets = results |> List.last() |> String.split("; ") |> Enum.map(&parse_set/1)
    %Game{id: id, sets: sets}
  end

  defp parse_set(string) do
    string |> String.split(", ") |> Enum.reduce(%{}, &parse_set_item/2)
  end

  defp parse_set_item(string, map) do
    {amount, color} = Regex.run(~r/(\d+) (\w+)/, string) |> tl() |> List.to_tuple()
    map |> Map.put(color |> String.to_atom(), amount |> String.to_integer())
  end
end
