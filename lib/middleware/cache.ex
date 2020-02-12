defmodule HN.MiddleWare.Cache do
  @behaviour Tesla.Middleware
  alias Tesla.Env

  def call(env, next, options) do
    # IO.puts(options)
    # Cachex.put(:hn_cache, "doof", "cha")
    # IO.inspect(Cachex.get(:hn_cache, env.url))

    case Cachex.get(:hn_cache, env.url) do
      {:ok, nil} ->
        IO.puts("miss")
        {:ok, response} = Tesla.run(env, next)
        Cachex.put(:hn_cache, env.url, response)
        {:ok, response}

      {:ok, val} ->
        IO.puts("hit")
        {:ok, val}

      _ ->
        IO.puts("dunno")
        Tesla.run(env, next)
    end

    # env
    # |> IO.inspect(label: "request")
    # |> Tesla.run(next)
    # |> IO.inspect(label: "response")
  end
end
