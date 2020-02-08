defmodule HNTest do
  use ExUnit.Case, async: true

  doctest HN, except: [fetch_stories: 2]

  setup do
    story = ~c({
        "by" : "dhouston",
        "descendants" : 71,
        "id" : 8863,
        "kids" : [ 9224, 8917, 8952, 8884, 8887, 8869, 8958, 8940, 8908, 9005, 8873, 9671, 9067, 9055, 8865, 8881, 8872, 8955, 10403, 8903, 8928, 9125, 8998, 8901, 8902, 8907, 8894, 8870, 8878, 8980, 8934, 8943, 8876 ],
        "score" : 104,
        "time" : 1175714200,
        "title" : "My YC app: Dropbox - Throw away your USB drive",
        "type" : "story",
        "url" : "http://www.getdropbox.com/u/2/screencast.html"
      }
    )

    user = ~c(
      {
        "about" : "This is a test",
        "created" : 1173923446,
        "id" : "jl",
        "karma" : 4226,
        "submitted" : [ 19464269, 18498213, 16659709, 16659632, 16659556, 14237416, 5252, 4752, 4586, 4289 ]
      }
    )

    max_item = "22059135"

    stories =
      ~c([22057737,22055976,22057989,22057576,22054163,22055867,22057173,22054600,22041741])

    updates = ~c({
      "items": [22058286, 22054517, 22055774, 22059007, 22058838, 22056363, 22056764],
      "profiles": ["nathan_compton", "chasd00", "yarapavan", "cagenut"]})

    Tesla.Mock.mock(fn env ->
      case env.url do
        "https://hacker-news.firebaseio.com/v0/item/8863.json" ->
          %Tesla.Env{status: 200, body: story}

        "https://hacker-news.firebaseio.com/v0/item/22058286.json" ->
          %Tesla.Env{status: 200, body: story}

        "https://hacker-news.firebaseio.com/v0/item/22054517.json" ->
          %Tesla.Env{status: 200, body: story}

        "https://hacker-news.firebaseio.com/v0/user/jl.json" ->
          %Tesla.Env{status: 200, body: user}

        "https://hacker-news.firebaseio.com/v0/maxitem.json" ->
          %Tesla.Env{status: 200, body: max_item}

        "https://hacker-news.firebaseio.com/v0/newstories.json" ->
          %Tesla.Env{status: 200, body: stories}

        "https://hacker-news.firebaseio.com/v0/topstories.json" ->
          %Tesla.Env{status: 200, body: stories}

        "https://hacker-news.firebaseio.com/v0/beststories.json" ->
          %Tesla.Env{status: 200, body: stories}

        "https://hacker-news.firebaseio.com/v0/askstories.json" ->
          %Tesla.Env{status: 200, body: stories}

        "https://hacker-news.firebaseio.com/v0/showstories.json" ->
          %Tesla.Env{status: 200, body: stories}

        "https://hacker-news.firebaseio.com/v0/jobstories.json" ->
          %Tesla.Env{status: 200, body: stories}

        "https://hacker-news.firebaseio.com/v0/updates.json" ->
          %Tesla.Env{status: 200, body: updates}
      end
    end)

    :ok
  end

  @tag runnable: false
  test "fetch an item" do
    {:ok, item} = HN.item(8863)
    assert item.by == "dhouston"
    assert item.id == 8863
    assert item === HN.item!("8863")
  end

  test "fetch a user" do
    {:ok, user} = HN.user("jl")
    assert user.id == "jl"
    assert user === HN.user!("jl")
  end

  test "fetch the max item id" do
    {:ok, max_item} = HN.max_item()
    assert max_item === HN.max_item!()
  end

  test "fetch stories" do
    {:ok, new_stories} = HN.new_stories()
    assert new_stories === HN.new_stories!()

    {:ok, new_stories} = HN.stories(:new)
    assert new_stories === HN.stories!(:new)

    {:ok, top_stories} = HN.top_stories()
    assert top_stories === HN.top_stories!()

    {:ok, top_stories} = HN.stories(:top)
    assert top_stories === HN.stories!(:top)

    {:ok, best_stories} = HN.best_stories()
    assert best_stories === HN.best_stories!()

    {:ok, best_stories} = HN.stories(:best)
    assert best_stories === HN.stories!(:best)

    {:ok, ask_stories} = HN.ask_stories()
    assert ask_stories === HN.ask_stories!()

    {:ok, ask_stories} = HN.stories(:ask)
    assert ask_stories === HN.stories!(:ask)

    {:ok, show_stories} = HN.show_stories()
    assert show_stories === HN.show_stories!()

    {:ok, show_stories} = HN.stories(:show)
    assert show_stories === HN.stories!(:show)

    {:ok, job_stories} = HN.job_stories()
    assert job_stories === HN.job_stories!()

    {:ok, job_stories} = HN.stories(:job)
    assert job_stories === HN.stories!(:job)
  end
end
