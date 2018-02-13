defmodule ExLogger.Mixfile do
  use Mix.Project

  def project do
    [
      app: :exlogger,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:timex, :poison, :logger]
    ]
  end

  defp deps do
    [
      {:poison, "~> 3.1"},
      {:timex, "~> 3.0"}
    ]
  end
end
