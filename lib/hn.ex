defmodule HN do
  @moduledoc "README.md"
             |> File.read!()
             |> String.split("<!-- MDOC !-->")
             |> Enum.fetch!(1)

  use Tesla, only: [:get], docs: false
  alias HN.{Item, User, Updates}

  @story_types [:new, :top, :best, :ask, :show, :job]
  @base_url_default "https://hacker-news.firebaseio.com/v0"

  adapter Tesla.Adapter.Hackney
  plug Tesla.Middleware.BaseUrl, Application.get_env(:hn, :base_url, @base_url_default)
  plug Tesla.Middleware.FollowRedirects, max_redirects: 3
  plug HN.MiddleWare.Decode

  @doc """
  Fetch an item by id. Returns {:ok, %HN.Item{}}.

  ## Example

      iex> HN.item(8863) # argument can be an integer or a string
      {:ok, %HN.Item{
           by: "dhouston",
           dead: nil,
           deleted: nil,
           descendants: 71,
           id: 8863,
           kids: [9224, 8917, 8952, 8884, 8887, 8869, 8958, 8940, 8908, 9005, 8873,
                  9671, 9067, 9055, 8865, 8881, 8872, 8955, 10403, 8903, 8928, 9125, 8998,
                  8901, 8902, 8907, 8894, 8870, 8878, 8980, 8934, 8943, 8876],
           parent: nil,
           parts: nil,
           poll: nil,
           score: 104,
           text: nil,
           time: 1175714200,
           title: "My YC app: Dropbox - Throw away your USB drive",
           type: "story",
           url: "http://www.getdropbox.com/u/2/screencast.html"
      }}

  """
  def item(id) when is_integer(id) do
    get("/item/" <> Integer.to_string(id) <> ".json", opts: [decode_as: %Item{}])
  end

  def item(id) do
    get("/item/" <> id <> ".json", opts: [decode_as: %Item{}])
  end

  @doc """
  Returns the item or raises an error.

  ## Example

      iex> HN.item!("abc")
      nil

  """
  def item!(id) when is_integer(id) do
    get!("/item/" <> Integer.to_string(id) <> ".json", opts: [decode_as: %Item{}])
  end

  def item!(id) do
    get!("/item/" <> id <> ".json", opts: [decode_as: %Item{}])
  end

  @doc """
  Fetch a user by name.

  ## Example

      iex> HN.user("jl")
      {:ok,
        %HN.User{
        about: "This is a test",
        created: 1173923446,
        delay: nil,
        id: "jl",
        karma: 4226,
        submitted: [19464269, 18498213, 16659709, 16659632, 16659556, 14237416,
            5252, 4752, 4586, 4289]
        }}

  """
  def user(name) do
    get("/user/" <> name <> ".json", opts: [decode_as: %User{}])
  end

  @doc """
  Returns the user or raises an error.
  """
  def user!(name) do
    get!("/user/" <> name <> ".json", opts: [decode_as: %User{}])
  end

  @doc """
  Fetch the most recent item id.

  ## Example

        iex> HN.max_item
        {:ok, "22059135"}

  """
  def max_item do
    get("/maxitem.json")
  end

  @doc """
  Returns the most recent item id or raises an error.
  """
  def max_item! do
    get!("/maxitem.json")
  end

  @doc """
  Fetch a list of story ids, passing in the type.

  Possible types are: :new, :top, :best, :ask, :show or :job

  ## Example

        iex> HN.stories(:new)
        {:ok,
         [22057737,22055976,22057989,22057576,22054163,22055867,22057173,22054600,22041741]}

  """
  def stories(type) do
    case Enum.member?(@story_types, type) do
      true -> get("/" <> Atom.to_string(type) <> "stories.json", opts: [decode_as: :json])
      false -> {:error, "Unknown story type '#{type}''"}
    end
  end

  @doc """
  Returns the latest stories for the given type, or raises an error.

  ## Example

      iex> HN.stories!(:unknown)
      ** (RuntimeError) Unknown story type 'unknown'
          (hn_ex 0.2.2) lib/hn.ex:145: HN.stories!/1

  """
  def stories!(type) do
    case Enum.member?(@story_types, type) do
      true -> get!("/" <> Atom.to_string(type) <> "stories.json", opts: [decode_as: :json])
      false -> raise(RuntimeError, "Unknown story type '#{type}'")
    end
  end

  @doc """
  Fetch a list of new story ids.

  ## Examples

        iex> HN.new_stories
        {:ok,
         [22057737,22055976,22057989,22057576,22054163,22055867,22057173,22054600,22041741]}

  """
  def new_stories, do: stories(:new)

  @doc """
  Returns the latest new stories or raises an error.

  ## Examples

        iex> HN.new_stories!
        {:ok,
         [22057737,22055976,22057989,22057576,22054163,22055867,22057173,22054600,22041741]}

  """
  def new_stories!, do: stories!(:new)

  @doc """
  Fetch a list of top story ids.

  ## Examples

        iex> HN.top_stories
        {:ok,
         [22057737,22055976,22057989,22057576,22054163,22055867,22057173,22054600,22041741]}

  """
  def top_stories, do: stories(:top)

  @doc """
  Returns the latest top stories or raises an error.

  ## Examples

        iex> HN.top_stories!
        {:ok,
         [22057737,22055976,22057989,22057576,22054163,22055867,22057173,22054600,22041741]}

  """
  def top_stories!, do: stories!(:top)

  @doc """
  Fetch a list of best story ids.

  ## Examples

        iex> HN.best_stories
        {:ok,
         [22057737,22055976,22057989,22057576,22054163,22055867,22057173,22054600,22041741]}

  """
  def best_stories, do: stories(:best)

  @doc """
  Returns the latest best stories or raises an error.

  ## Examples

        iex> HN.best_stories!
        {:ok,
         [22057737,22055976,22057989,22057576,22054163,22055867,22057173,22054600,22041741]}

  """
  def best_stories!, do: stories!(:best)

  @doc """
  Fetch a list of ask story ids.

  ## Examples

      iex> HN.ask_stories
      {:ok,
       [22057737,22055976,22057989,22057576,22054163,22055867,22057173,22054600,22041741]}

  """
  def ask_stories, do: stories(:ask)

  @doc """
  Returns the latest ask stories or raises an error.

  ## Examples

      iex> HN.ask_stories!
      {:ok,
       [22057737,22055976,22057989,22057576,22054163,22055867,22057173,22054600,22041741]}

  """
  def ask_stories!, do: stories!(:ask)

  @doc """
  Fetch a list of show story ids.

  ## Examples

        iex> HN.show_stories
        {:ok,
         [22057737,22055976,22057989,22057576,22054163,22055867,22057173,22054600,22041741]}

  """
  def show_stories, do: stories(:show)

  @doc """
  Returns the latest show stories or raises an error.

  ## Examples

        iex> HN.show_stories!
        {:ok,
         [22057737,22055976,22057989,22057576,22054163,22055867,22057173,22054600,22041741]}

  """
  def show_stories!, do: stories!(:show)

  @doc """
  Fetch a list of job story ids.

  ## Examples

        iex> HN.job_stories
        {:ok,
         [22057737,22055976,22057989,22057576,22054163,22055867,22057173,22054600,22041741]}

  """
  def job_stories, do: stories(:job)

  @doc """
  Returns the latest job stories or raises an error.

  ## Examples

        iex> HN.job_stories!
        {:ok,
         [22057737,22055976,22057989,22057576,22054163,22055867,22057173,22054600,22041741]}

  """
  def job_stories!, do: stories!(:job)

  @doc """
  Fetch recent item and profile changes.

  ## Examples

      iex> HN.updates
      {:ok,
        %HN.Updates{
          items: [22058286, 22054517, 22055774, 22059007, 22058838, 22056363, 22056764],
          profiles: ["nathan_compton", "chasd00", "yarapavan", "cagenut"]
      }}

  """
  def updates do
    get("/updates.json", opts: [decode_as: %Updates{}])
  end

  @doc """
  Returns the latest updates or raises an error.

  ## Examples

      iex> HN.updates!
      {:ok,
        %HN.Updates{
          items: [22058286, 22054517, 22055774, 22059007, 22058838, 22056363, 22056764],
          profiles: ["nathan_compton", "chasd00", "yarapavan", "cagenut"]
      }}

  """
  def updates! do
    get!("/updates.json", opts: [decode_as: %Updates{}])
  end

  @doc """
  Helper to fetch multiple stories in parellel using Task async/await.

  Accepts an optional limit, which will limit the list of ids before fetching
  the items.

  ## Examples

        iex> HN.top_stories |> HN.fetch_stories
        [%HN.Item{
           by: "dhouston",
           dead: nil,
           deleted: nil,
           ...},
          ...
        ]
  """
  defdelegate fetch_stories(ids, limit \\ nil), to: HN.Helpers
end
