defmodule ExLogger.Mixfile do
  use Mix.Project

  @version "0.1.0"
  @url "https://github.com/soundtrackyourbrand/exlogger"

  def project do
    [
      app: :exlogger,
      version: @version,
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      build_embedded: Mix.env == :prod,
      deps: deps(),
      package: package(),
      description: "JSON log formatter for the elixir Logger",
      docs: [
        source_ref: "v#{@version}",
        source_url: @url
      ]
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
      {:timex, "~> 3.0"},
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end

  defp package do
    %{
      licenses: ["MIT"],
      maintainers: ["Sven Widén"],
      links: %{"GitHub" => @url}
    }
  end
end
