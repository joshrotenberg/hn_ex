# HN

<!-- MDOC !-->

[![github.com](https://github.com/joshrotenberg/hn_ex/workflows/Elixir%20CI/badge.svg)](https://github.com/joshrotenberg/hn_ex/actions)
[![hex.pm](https://img.shields.io/hexpm/v/hn_ex.svg)](https://hex.pm/packages/hn_ex)
[![hex.pm](https://img.shields.io/badge/docs-hexpm-blue.svg)](https://hexdocs.pm/hn_ex)
[![hex.pm](https://img.shields.io/hexpm/dt/hn_ex.svg)](https://hex.pm/packages/hn_ex)
[![hex.pm](https://img.shields.io/hexpm/l/hn_ex.svg)](https://hex.pm/packages/hn_ex)
[![github.com](https://img.shields.io/github/last-commit/joshrotenberg/hn_ex.svg)](https://github.com/joshrotenberg/hn_ex/commits/master)

A simple Hacker News API client in Elixir based on the [official Firebase
API](https://github.com/HackerNews/API).

## Usage

Each endpoint (see API docs above) has a corresponding function call (and
unsafe version), for example:

```elixir
iex> HN.item(8863) # argument can be an integer or a string
{:ok, %HN.Item{
     by: "dhouston",
     dead: nil,
     deleted: nil,
     descendants: 71,
     ...
}}

# or

iex> HN.item!(8863)
 %HN.Item{
     by: "dhouston",
     dead: nil,
     deleted: nil,
     descendants: 71,
     ...
}}
```

## Installation

Add `hn_ex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:hn_ex, "~> 0.1"}
  ]
end
```
