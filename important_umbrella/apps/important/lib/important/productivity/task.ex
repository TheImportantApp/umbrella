defmodule Important.Productivity.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :completed, :utc_datetime
    field :created, :utc_datetime
    field :description, :string
    field :dtstamp, :utc_datetime
    field :dtstart, :utc_datetime
    field :due, :utc_datetime
    field :last_modifier, :utc_datetime
    field :organizer, :string
    field :percent_complete, :integer
    field :priority, :integer
    field :recurrence_id, :utc_datetime
    field :rrule, :string
    field :sequence, :integer
    field :status, :string
    field :summary, :string
    field :uid, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [
      :uid,
      :dtstamp,
      :completed,
      :created,
      :description,
      :dtstart,
      :due,
      :last_modifier,
      :organizer,
      :percent_complete,
      :priority,
      :recurrence_id,
      :rrule,
      :sequence,
      :status,
      :summary,
      :url
    ])
    |> validate_required([
      :uid,
      :dtstamp,
      :completed,
      :created,
      :description,
      :dtstart,
      :due,
      :last_modifier,
      :organizer,
      :percent_complete,
      :priority,
      :recurrence_id,
      :rrule,
      :sequence,
      :status,
      :summary,
      :url
    ])
  end
end
