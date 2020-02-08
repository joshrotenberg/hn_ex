defmodule HN.CLI do
  def main(args \\ []) do
    {opts, _, _} =
      OptionParser.parse(args,
        strict: [
          top: :boolean,
          best: :boolean,
          new: :boolean,
          ask: :boolean,
          show: :boolean,
          job: :boolean,
          limit: :integer
        ],
        aliases: [t: :top, b: :best, n: :new, a: :ask, s: :show, j: :job, l: :limit]
      )

    stories =
      opts
      |> Keyword.keys()
      |> List.first()
      |> HN.stories!()

    stories
    |> HN.fetch_stories(Keyword.get(opts, :limit, Enum.count(stories)))
    |> Enum.each(fn i -> puts_item(i) end)
  end

  defp puts_item(item) do
    [
      :bright,
      item.title,
      :reset,
      " ",
      :blue,
      item.url
    ]
    |> Bunt.puts()

    [
      "\t",
      Integer.to_string(item.score),
      " points by ",
      item.by,
      " ",
      Integer.to_string(item.descendants),
      " comments ",
      :blue,
      "https://news.ycombinator.com/item?id=",
      Integer.to_string(item.id)
    ]
    |> Bunt.puts()
  end
end
