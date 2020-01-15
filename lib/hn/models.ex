defmodule HN.Item do
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
  defstruct [:id, :delay, :created, :karma, :about, :submitted]
end

defmodule HN.Updates do
  defstruct [:items, :profiles]
end
