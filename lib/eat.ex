defmodule Eat do
  @moduledoc """
  Eat is a cat clone with elixir magic.
  """

  @default_break_point 7

  def main(args \\ []) do
    terminal_width = width()

    {opts, files} = parse_args(args)

    break_point =
      case opts do
        %{break_point: bp} when is_integer(bp) and rem(bp, 2) == 1 and bp >= 5 ->
          bp
        _ ->
          @default_break_point
      end

    if Map.get(opts, :help, false) or files == [] do
      Help.print_help()
    else
      Enum.each(files, fn file -> concatenate(file, terminal_width, break_point) end)
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
      OptionParser.parse(args,
        switches: [help: :boolean, break_point: :integer],
        aliases: [h: :help, b: :break_point]
      )
    {Enum.into(opts, %{}), files}
  end

  defp concatenate(file, terminal_width, break_point) do
    case File.read(file) do
      {:ok, content} ->
        if String.valid?(content) do
          fancy(file, content, terminal_width, break_point)
        else
          fancy(file, "🚨 #{BColors.fail}File is not a valid UTF-8 file.#{BColors.endc} 🚨", terminal_width, break_point)
        end
      {:error, reason} ->
        IO.puts "#{BColors.fail}Error reading #{file}: #{reason}#{BColors.endc}"
    end
  end

  defp fancy(file, content, terminal_width, break_point) do
    PrettyPrinter.div_up(terminal_width, break_point)
    PrettyPrinter.format_file(file, break_point)
    PrettyPrinter.div_mid(terminal_width, break_point)
    PrettyPrinter.format_content(content, terminal_width, break_point)
    PrettyPrinter.div_low(terminal_width, break_point)
  end
end
