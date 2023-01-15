defmodule Important.ProductivityFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Important.Productivity` context.
  """

  @doc """
  Generate a task.
  """
  def task_fixture(attrs \\ %{}) do
    {:ok, task} =
      attrs
      |> Enum.into(%{
        completed: ~U[2023-01-14 04:25:00Z],
        created: ~U[2023-01-14 04:25:00Z],
        description: "some description",
        dtstamp: ~U[2023-01-14 04:25:00Z],
        dtstart: ~U[2023-01-14 04:25:00Z],
        due: ~U[2023-01-14 04:25:00Z],
        last_modifier: ~U[2023-01-14 04:25:00Z],
        organizer: "some organizer",
        percent_complete: 42,
        priority: 42,
        recurrence_id: ~U[2023-01-14 04:25:00Z],
        rrule: "some rrule",
        sequence: 42,
        status: "some status",
        summary: "some summary",
        uid: "some uid",
        url: "some url"
      })
      |> Important.Productivity.create_task()

    task
  end
end
