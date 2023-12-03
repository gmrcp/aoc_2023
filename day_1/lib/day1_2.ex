defmodule Day1_part_2 do
  @spelled_int "one|two|three|four|five|six|seven|eight|nine"
  @replace_integer_map %{
    "one" => "1",
    "two" => "2",
    "three" => "3",
    "four" => "4",
    "five" => "5",
    "six" => "6",
    "seven" => "7",
    "eight" => "8",
    "nine" => "9"
  }

  def main(asset) do
    read_input("assets/#{asset}.txt")
    |> Enum.map(&match_spelled_integer/1)
    |> Enum.map(&filter_only_digits/1)
    |> Enum.map(&parse_code/1)
    |> Enum.reduce(&(&1 + &2))
  end

  defp read_input(file_path) do
    File.read!(file_path) |> String.split("\n")
  end

  defp filter_only_digits(code) do
    Regex.replace(~r/[^\d]/, code, "")
  end

  defp parse_code(string) do
    list = string |> String.graphemes()

    {parsed_int, _} =
      [List.first(list), List.last(list)]
      |> Enum.join()
      |> Integer.parse()

    parsed_int
  end

  defp match_spelled_integer(string) do
    string
    |> replace_spelled_integers(~r/(#{@spelled_int})(?=.*\d)/, false)
    |> String.reverse()
    |> replace_spelled_integers(~r/(#{@spelled_int |> String.reverse()})(?=.*\d)/, true)
    |> String.reverse()
    |> IO.inspect()
  end

  defp replace_spelled_integers(string, regex, true = _is_reversed) do
    if Regex.match?(regex, string) do
      Regex.replace(regex, string, &map_spelled_integer(&1, &2 |> String.reverse()),
        global: false
      )
    else
      string
    end
  end

  defp replace_spelled_integers(string, regex, _) do
    if Regex.match?(regex, string) do
      Regex.replace(regex, string, &map_spelled_integer(&1, &2), global: false)
    else
      string
    end
  end

  defp map_spelled_integer(_, string) do
    @replace_integer_map |> Map.get(string)
  end
end
