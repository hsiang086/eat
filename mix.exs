defmodule Eat.MixProject do
  use Mix.Project

  def project do
    [
      app: :eat,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: escript_config()
    ]
  end

  defp deps do
    []
  end

  defp escript_config do
    [main_module: Eat]
  end
end
