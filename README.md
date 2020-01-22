# HN

A simple Hacker News API client in Elixir.

See https://hexdocs.pm/hn_ex/HN.html for full documentation.

See https://github.com/HackerNews/API for a thorough description of the API and the fields returned from the various calls.

##  API Calls

Each endpoint (see API docs above) has a corresponding function call (and unsafe version), for example:

```
      iex> HN.item(8863) # argument can be an integer or a string
      {:ok, %HN.Item{
           by: "dhouston",
           dead: nil,
           deleted: nil,
           descendants: 71,
           ...
      }}
      or 
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

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `hn_ex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:hn_ex, "~> 0.1"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/hn_ex](https://hexdocs.pm/hn_ex).

