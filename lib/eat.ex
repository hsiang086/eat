defmodule Eat do
  @moduledoc """
  Eat is a cat clone with elixir magic.
  """

  def main(args \\ []) do
    {opts, files} = parse_args(args)

    if opts[:help] do
      print_help()
    else
      case files do
        [] ->
          print_help()
        _ ->
          Enum.each(files, &concatenate/1)
      end
    end
  end

  def width do
    case :io.columns do
      {:ok, width} -> width
      _ -> :error
    end
  end

  defp parse_args(args) do
    {opts, files, _} =
      args
      |> OptionParser.parse(switches: [help: :boolean], aliases: [h: :help])
    {opts, files}
  end

  defp print_help do
    IO.puts """
    #{BColors.header}a cat clone with elixir magic.#{BColors.endc}\n
    #{BColors.ok_blue}Usage: eat [options] [file ...]#{BColors.endc}\n
    #{BColors.bold}#{BColors.underline}Options:#{BColors.endc}
      #{BColors.ok_cyan}-h, --help  Show the help message.#{BColors.endc}
    """
  end

  defp concatenate(file) do
    case File.read(file) do
      {:ok, content} ->
        fancy(file, content)
      {:error, reason} ->
        IO.puts "#{BColors.fail}Error reading #{file}: #{reason}#{BColors.endc}"
    end
  end

  defp fancy(file, content) do
    break_point = 5
    terminal_width = width()
    IO.write "#{BColors.thin}"
    IO.write "#{String.duplicate("─", break_point)}"
    IO.write "┬"
    IO.write "#{String.duplicate("─", terminal_width - break_point - 1)}"
    IO.write "#{BColors.endc}\n"
    IO.write "#{String.duplicate(" ", break_point)}"
    IO.write "#{BColors.thin}│#{BColors.endc}"
    IO.write " File: #{BColors.bold}#{file}#{BColors.endc}\n"
    IO.write "#{BColors.thin}"
    IO.write "#{String.duplicate("─", break_point)}"
    IO.write "┼"
    IO.write "#{String.duplicate("─", terminal_width - break_point - 1)}"
    IO.write "#{BColors.endc}\n"
    Enum.with_index(String.split(content, "\n"))
    |> Enum.each(fn {line, index} ->
      index_length = String.length("#{index}")
      IO.write "#{String.duplicate(" ", 2)}"
      IO.write "#{index}"
      IO.write "#{String.duplicate(" ", 3 - index_length)}"
      IO.write "#{BColors.thin}│#{BColors.endc}"
      IO.write " "
      IO.puts line
    end)
    IO.write "#{BColors.thin}"
    IO.write "#{String.duplicate("─", break_point)}"
    IO.write "┴"
    IO.write "#{String.duplicate("─", terminal_width - break_point - 1)}\n"
    IO.write "#{BColors.endc}"
  end
end
