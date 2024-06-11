defmodule BColors do
  @moduledoc """
  ANSI color codes for terminal text formatting.
  """

  @header "\e[95m"
  @ok_blue "\e[94m"
  @ok_cyan "\e[96m"
  @ok_green "\e[92m"
  @warning "\e[93m"
  @fail "\e[91m"
  @thin "\e[90m"
  @endc "\e[0m"
  @bold "\e[1m"
  @underline "\e[4m"

  def header, do: @header
  def ok_blue, do: @ok_blue
  def ok_cyan, do: @ok_cyan
  def ok_green, do: @ok_green
  def warning, do: @warning
  def fail, do: @fail
  def thin, do: @thin
  def endc, do: @endc
  def bold, do: @bold
  def underline, do: @underline
end
