defmodule HN.MixProject do
  use Mix.Project

  def project do
    [
      app: :hn_ex,
      version: "0.2.2",
      elixir: "~> 1.9",
      source_url: "https://github.com/joshrotenberg/hn_ex",
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
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
      {:tesla, "~> 1.3.3"},
      {:hackney, "~> 1.16"},
      {:poison, "~> 4.0"},

      # test
      {:excoveralls, "~> 0.13.2", only: :test},
      {:credo, "~> 1.4.1", only: [:dev, :test], runtime: false},

      # docs
      {:ex_doc, "~> 0.23", only: :dev}
    ]
  end
end
