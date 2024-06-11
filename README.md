# Eat

Eat is a cat clone with Elixir magic. It reads and prints file contents to the terminal with additional formatting features such as line numbers and customizable break points.

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
  - [Command Line Options](#command-line-options)
- [Examples](#examples)
- [Development](#development)
  - [Directory Structure](#directory-structure)
  - [Modules](#modules)
- [Contributing](#contributing)
- [License](#license)

## Installation

To install Eat, you need to have Elixir installed on your system. Follow the instructions [here](https://elixir-lang.org/install.html) to install Elixir.

Clone this repository:

```bash
git clone https://github.com/yourusername/eat.git
cd eat
```

Build the project:

```bash
mix escript.build
```

This will generate an executable `eat` in the `./bin` directory.

Or you can run the installation script (for macOS only):

```bash
curl -fsSL https://raw.githubusercontent.com/hsiang086/eat/v0.1.0/install.sh | bash
```

## Usage

Run the `eat` executable with the desired options and files:

```bash
./bin/eat [options] [file ...]
```

### Command Line Options

- `-h`, `--help`: Show the help message.
- `-b`, `--break-point <n>`: Set the break point. The value of `n` must be an odd number and at least 5. If the condition is not met, the default value of 7 will be used.

## Examples

### Basic Usage

Print the contents of a file:

```bash
./bin/eat example.txt
```

### Custom Break Point

Print the contents of a file with a custom break point:

```bash
./bin/eat -b 9 example.txt
```

### Multiple Files

Print the contents of multiple files:

```bash
./bin/eat file1.txt file2.txt
```

### Help

Show the help message:

```bash
./bin/eat --help
```

## Development

### Directory Structure

- `lib/`: Contains the Elixir source files.
- `lib/eat.ex`: Main module handling command-line arguments and file processing.
- `lib/pretty_printer.ex`: Utility module for formatting and printing content.
- `test/`: Contains test files.

### Modules

#### Eat

The main module responsible for:

- Parsing command-line arguments.
- Reading files.
- Handling formatting and printing of file contents.

#### PrettyPrinter

A helper module for:

- Printing formatted dividers.
- Formatting file names and content.
- Printing line numbers with padding.

### Example Code

#### Main Module (`Eat`)

```elixir
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
      print_help()
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

  defp print_help do
    IO.puts """
    #{BColors.header}a cat clone with elixir magic.#{BColors.endc}\n
    #{BColors.ok_blue}Usage: eat [options] [file ...]#{BColors.endc}\n
    #{BColors.bold}#{BColors.underline}Options:#{BColors.endc}
      #{BColors.ok_cyan}-h, --help  Show the help message.#{BColors.endc}
      #{BColors.ok_cyan}-b, --break-point <n>  Set the break point.#{BColors.endc}
    """
  end

  defp concatenate(file, terminal_width, break_point) do
    case File.read(file) do
      {:ok, content} ->
        fancy(file, content, terminal_width, break_point)
      {:error, reason} ->
        IO.puts "#{BColors.fail}Error reading #{file}: #{reason}#{BColors.endc}"
    end
  end

  defp fancy(file, content, terminal_width, break_point) do
    PrettyPrinter.div_up(terminal_width, break_point)
    PrettyPrinter.format_file(file, break_point)
    PrettyPrinter.div_mid(terminal_width, break_point)
    PrettyPrinter.format_content(content, break_point)
    PrettyPrinter.div_low(terminal_width, break_point)
  end
end
```

#### PrettyPrinter Module

```elixir
defmodule PrettyPrinter do
  def div_up(terminal_width, break_point) do
    IO.puts(String.duplicate("-", terminal_width))
  end

  def format_file(file, break_point) do
    IO.puts("File: #{file}")
  end

  def div_mid(terminal_width, break_point) do
    IO.puts(String.duplicate("-", terminal_width))
  end

  def format_content(content, break_point) do
    Enum.with_index(String.split(content, "\n"))
    |> Enum.each(fn {line, index} ->
      index_str = Integer.to_string(index)
      index_length = String.length(index_str)
      half_break = div(break_point, 2)
      padding_left = String.duplicate(" ", half_break - div(index_length, 2))
      padding_right = String.duplicate(" ", break_point - half_break - div(index_length, 2) - index_length)

      IO.write("#{padding_left}#{index}#{padding_right}")
      IO.write("#{BColors.thin}│#{BColors.endc}")
      IO.write(" ")
      IO.puts(line)
    end)
  end

  def div_low(terminal_width, break_point) do
    IO.puts(String.duplicate("-", terminal_width))
  end
end
```

## Contributing

1. Fork the repository.
2. Create your feature branch (`git checkout -b feature/new-feature`).
3. Commit your changes (`git commit -am 'Add some feature'`).
4. Push to the branch (`git push origin feature/new-feature`).
5. Create a new Pull Request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
