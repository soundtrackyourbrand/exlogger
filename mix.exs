defmodule ExLogger.Mixfile do
  use Mix.Project

  @version "0.3.0"
  @url "https://github.com/soundtrackyourbrand/exlogger"

  def project do
    [
      app: :exlogger,
      version: @version,
      elixir: "~> 1.5",
      start_permanent: Mix.env() == :prod,
      build_embedded: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      description: "JSON log formatter for the elixir Logger",
      name: "ExLogger",
      source_ref: "v#{@version}",
      source_url: @url,
      docs: [
        main: "ExLogger",
        extras: ["README.md"]
      ]
    ]
  end

  def application do
    [
      extra_applications: [:poison, :logger]
    ]
  end

  defp deps do
    [
      {:poison, "~> 4.0"},
      {:ex_doc, "~> 0.19.0", only: :dev, runtime: false}
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
