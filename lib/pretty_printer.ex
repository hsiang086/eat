defmodule PrettyPrinter do
  @moduledoc """
  PrettyPrinter is a module that provides functions to print formatted text to the terminal.
  """

  def div_up(width, break_point) do
    IO.write "#{BColors.thin}"
    IO.write "#{String.duplicate("─", break_point)}"
    IO.write "┬"
    IO.write "#{String.duplicate("─", width - break_point - 1)}"
    IO.write "#{BColors.endc}\n"
  end

  def div_mid(width, break_point) do
    IO.write "#{BColors.thin}"
    IO.write "#{String.duplicate("─", break_point)}"
    IO.write "┼"
    IO.write "#{String.duplicate("─", width - break_point - 1)}"
    IO.write "#{BColors.endc}\n"
  end

  def div_low(width, break_point) do
    IO.write "#{BColors.thin}"
    IO.write "#{String.duplicate("─", break_point)}"
    IO.write "┴"
    IO.write "#{String.duplicate("─", width - break_point - 1)}"
    IO.write "#{BColors.endc}\n"
  end

  def format_file(file, break_point) do
    IO.write "#{String.duplicate(" ", break_point)}"
    IO.write "#{BColors.thin}│#{BColors.endc}"
    IO.write " File: #{BColors.bold}#{file}#{BColors.endc}\n"
  end

  def format_content(content, width, break_point) do
    line_max = width - break_point - 2
    half_break_point = div(break_point+1, 2)
    Enum.with_index(String.split(content, "\n"))
    |> Enum.each(fn {line, index} ->
      index = index + 1
      index_length = String.length("#{index}")
      line_length = String.length(line)
      exeeded = div(line_length-1, line_max)
      for i <- 0..exeeded do
        if i > 0 do
          IO.write "#{String.duplicate(" ", break_point)}"
        else
          IO.write "#{String.duplicate(" ", half_break_point-index_length)}"
          IO.write "#{BColors.thin}#{index}#{BColors.endc}"
          IO.write "#{String.duplicate(" ", half_break_point-1)}"
        end
        IO.write "#{BColors.thin}│ #{BColors.endc}"
        IO.write String.slice(line, i*line_max, line_max)
      end
      IO.write "\n"
    end)
  end
end
