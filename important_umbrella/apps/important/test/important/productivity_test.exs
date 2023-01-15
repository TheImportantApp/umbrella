defmodule Important.ProductivityTest do
  use Important.DataCase

  alias Important.Productivity

  describe "tasks" do
    alias Important.Productivity.Task

    import Important.ProductivityFixtures

    @invalid_attrs %{
      completed: nil,
      created: nil,
      description: nil,
      dtstamp: nil,
      dtstart: nil,
      due: nil,
      last_modifier: nil,
      organizer: nil,
      percent_complete: nil,
      priority: nil,
      recurrence_id: nil,
      rrule: nil,
      sequence: nil,
      status: nil,
      summary: nil,
      uid: nil,
      url: nil
    }

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert Productivity.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert Productivity.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      valid_attrs = %{
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
      }

      assert {:ok, %Task{} = task} = Productivity.create_task(valid_attrs)
      assert task.completed == ~U[2023-01-14 04:25:00Z]
      assert task.created == ~U[2023-01-14 04:25:00Z]
      assert task.description == "some description"
      assert task.dtstamp == ~U[2023-01-14 04:25:00Z]
      assert task.dtstart == ~U[2023-01-14 04:25:00Z]
      assert task.due == ~U[2023-01-14 04:25:00Z]
      assert task.last_modifier == ~U[2023-01-14 04:25:00Z]
      assert task.organizer == "some organizer"
      assert task.percent_complete == 42
      assert task.priority == 42
      assert task.recurrence_id == ~U[2023-01-14 04:25:00Z]
      assert task.rrule == "some rrule"
      assert task.sequence == 42
      assert task.status == "some status"
      assert task.summary == "some summary"
      assert task.uid == "some uid"
      assert task.url == "some url"
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Productivity.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()

      update_attrs = %{
        completed: ~U[2023-01-15 04:25:00Z],
        created: ~U[2023-01-15 04:25:00Z],
        description: "some updated description",
        dtstamp: ~U[2023-01-15 04:25:00Z],
        dtstart: ~U[2023-01-15 04:25:00Z],
        due: ~U[2023-01-15 04:25:00Z],
        last_modifier: ~U[2023-01-15 04:25:00Z],
        organizer: "some updated organizer",
        percent_complete: 43,
        priority: 43,
        recurrence_id: ~U[2023-01-15 04:25:00Z],
        rrule: "some updated rrule",
        sequence: 43,
        status: "some updated status",
        summary: "some updated summary",
        uid: "some updated uid",
        url: "some updated url"
      }

      assert {:ok, %Task{} = task} = Productivity.update_task(task, update_attrs)
      assert task.completed == ~U[2023-01-15 04:25:00Z]
      assert task.created == ~U[2023-01-15 04:25:00Z]
      assert task.description == "some updated description"
      assert task.dtstamp == ~U[2023-01-15 04:25:00Z]
      assert task.dtstart == ~U[2023-01-15 04:25:00Z]
      assert task.due == ~U[2023-01-15 04:25:00Z]
      assert task.last_modifier == ~U[2023-01-15 04:25:00Z]
      assert task.organizer == "some updated organizer"
      assert task.percent_complete == 43
      assert task.priority == 43
      assert task.recurrence_id == ~U[2023-01-15 04:25:00Z]
      assert task.rrule == "some updated rrule"
      assert task.sequence == 43
      assert task.status == "some updated status"
      assert task.summary == "some updated summary"
      assert task.uid == "some updated uid"
      assert task.url == "some updated url"
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = Productivity.update_task(task, @invalid_attrs)
      assert task == Productivity.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = Productivity.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Productivity.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = Productivity.change_task(task)
    end
  end
end
