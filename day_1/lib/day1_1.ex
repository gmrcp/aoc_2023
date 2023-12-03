defmodule Day1 do
  def main do
    read_input("assets/input_1.txt")
    |> Enum.map(&get_number_from_code/1)
    |> Enum.map(&parse_code/1)
    |> Enum.reduce(&(&1 + &2))
  end

  defp read_input(file_path) do
    File.read!(file_path)
    |> String.split("\n")
  end

  defp get_number_from_code(code) do
    code
    |> String.graphemes()
    |> Enum.filter(&parse_integer/1)
  end

  defp parse_integer(string) do
    case Integer.parse(string) do
      {number, ""} -> number
      _ -> nil
    end
  end

  defp parse_code(list) do
    [List.first(list), List.last(list)]
    |> Enum.join()
    |> String.to_integer()
    |> IO.inspect()
  end
end
