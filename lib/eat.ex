defmodule Eat do
  def main(args \\ []) do
    case args do
      [] ->
        IO.puts "Usage: eat <file1> [<file2> ...]"
      files ->
        Enum.each(files, &print_file/1)
    end
  end

  defp print_file(file) do
    case File.read(file) do
      {:ok, content} ->
        IO.puts content
      {:error, reason} ->
        IO.puts "Error reading #{file}: #{reason}"
    end
  end
end
