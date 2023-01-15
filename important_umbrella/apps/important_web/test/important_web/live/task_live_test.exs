defmodule ImportantWeb.TaskLiveTest do
  use ImportantWeb.ConnCase

  import Phoenix.LiveViewTest
  import Important.ProductivityFixtures

  @create_attrs %{
    completed: "2023-01-14T04:25:00Z",
    created: "2023-01-14T04:25:00Z",
    description: "some description",
    dtstamp: "2023-01-14T04:25:00Z",
    dtstart: "2023-01-14T04:25:00Z",
    due: "2023-01-14T04:25:00Z",
    last_modifier: "2023-01-14T04:25:00Z",
    organizer: "some organizer",
    percent_complete: 42,
    priority: 42,
    recurrence_id: "2023-01-14T04:25:00Z",
    rrule: "some rrule",
    sequence: 42,
    status: "some status",
    summary: "some summary",
    uid: "some uid",
    url: "some url"
  }
  @update_attrs %{
    completed: "2023-01-15T04:25:00Z",
    created: "2023-01-15T04:25:00Z",
    description: "some updated description",
    dtstamp: "2023-01-15T04:25:00Z",
    dtstart: "2023-01-15T04:25:00Z",
    due: "2023-01-15T04:25:00Z",
    last_modifier: "2023-01-15T04:25:00Z",
    organizer: "some updated organizer",
    percent_complete: 43,
    priority: 43,
    recurrence_id: "2023-01-15T04:25:00Z",
    rrule: "some updated rrule",
    sequence: 43,
    status: "some updated status",
    summary: "some updated summary",
    uid: "some updated uid",
    url: "some updated url"
  }
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

  defp create_task(_) do
    task = task_fixture()
    %{task: task}
  end

  describe "Index" do
    setup [:create_task]

    test "lists all tasks", %{conn: conn, task: task} do
      {:ok, _index_live, html} = live(conn, ~p"/tasks")

      assert html =~ "Listing Tasks"
      assert html =~ task.description
    end

    test "saves new task", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/tasks")

      assert index_live |> element("a", "New Task") |> render_click() =~
               "New Task"

      assert_patch(index_live, ~p"/tasks/new")

      assert index_live
             |> form("#task-form", task: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#task-form", task: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/tasks")

      assert html =~ "Task created successfully"
      assert html =~ "some description"
    end

    test "updates task in listing", %{conn: conn, task: task} do
      {:ok, index_live, _html} = live(conn, ~p"/tasks")

      assert index_live |> element("#tasks-#{task.id} a", "Edit") |> render_click() =~
               "Edit Task"

      assert_patch(index_live, ~p"/tasks/#{task}/edit")

      assert index_live
             |> form("#task-form", task: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#task-form", task: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/tasks")

      assert html =~ "Task updated successfully"
      assert html =~ "some updated description"
    end

    test "deletes task in listing", %{conn: conn, task: task} do
      {:ok, index_live, _html} = live(conn, ~p"/tasks")

      assert index_live |> element("#tasks-#{task.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#task-#{task.id}")
    end
  end

  describe "Show" do
    setup [:create_task]

    test "displays task", %{conn: conn, task: task} do
      {:ok, _show_live, html} = live(conn, ~p"/tasks/#{task}")

      assert html =~ "Show Task"
      assert html =~ task.description
    end

    test "updates task within modal", %{conn: conn, task: task} do
      {:ok, show_live, _html} = live(conn, ~p"/tasks/#{task}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Task"

      assert_patch(show_live, ~p"/tasks/#{task}/show/edit")

      assert show_live
             |> form("#task-form", task: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#task-form", task: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/tasks/#{task}")

      assert html =~ "Task updated successfully"
      assert html =~ "some updated description"
    end
  end
end
