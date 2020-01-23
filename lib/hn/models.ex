defmodule HN.Item do
  @moduledoc false

  defstruct [
    :id,
    :deleted,
    :type,
    :by,
    :time,
    :text,
    :dead,
    :parent,
    :poll,
    :kids,
    :url,
    :score,
    :title,
    :parts,
    :descendants
  ]
end

defmodule HN.User do
  @moduledoc false

  defstruct [:id, :delay, :created, :karma, :about, :submitted]
end

defmodule HN.Updates do
  @moduledoc false

  defstruct [:items, :profiles]
end
