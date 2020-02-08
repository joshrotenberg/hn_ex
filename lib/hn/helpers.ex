defmodule HN.Helpers do
  @moduledoc false

  def fetch_stories(ids, limit \\ nil) do
    case ids do
      {:ok, ids} -> fetch_all(ids, limit)
      ids -> fetch_all(ids, limit)
    end
  end

  defp fetch_all(ids, limit) do
    ids
    |> take_or_all(limit)
    |> Enum.map(&Task.async(fn -> HN.item!(&1) end))
    |> Enum.map(&Task.await/1)
  end

  defp take_or_all(ids, limit \\ nil) do
    case limit do
      nil -> ids
      _ -> Enum.take(ids, limit)
    end
  end
end
