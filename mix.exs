defmodule HN.MixProject do
  use Mix.Project

  def project do
    [
      app: :hn_ex,
      version: "0.1.0",
      elixir: "~> 1.9",
      source_url: "https://github.com/joshrotenberg/hn_ex",
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],
      description: description(),
      package: package(),
      deps: deps()
    ]
  end

  defp description do
    "A simple Hacker News API client in Elixir."
  end

  defp package do
    [
      maintainers: ["Josh Rotenberg"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/joshrotenberg/hn_ex"}
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:tesla, "~> 1.3.0"},
      {:hackney, "~> 1.14.0"},
      {:poison, "~> 4.0"},

      # test
      {:excoveralls, "~> 0.10", only: :test},
      {:credo, "~> 1.1.0", only: [:dev, :test], runtime: false}
    ]
  end
end
