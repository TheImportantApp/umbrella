defmodule ImportantWeb.TaskLive.FormComponent do
  use ImportantWeb, :live_component

  alias Important.Productivity
  alias Uniq.UUID

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage task records in your database.</:subtitle>
      </.header>

      <.simple_form
        :let={f}
        for={@changeset}
        id="task-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={{f, :summary}} type="text" label="Summary" />
        <.input field={{f, :description}} type="text" label="Description" />
        <.input
          field={{f, :priority}}
          type="select"
          options={[
            {Productivity.Task.label(:priority, 1), 1},
            {Productivity.Task.label(:priority, 2), 2},
            {Productivity.Task.label(:priority, 5), 5},
            {Productivity.Task.label(:priority, 9), 9}
          ]}
          label="Priority"
        />
        <.input
          field={{f, :status}}
          type="select"
          options={[
            {Productivity.Task.label(:status, "NEEDS-ACTION"), "NEEDS-ACTION"},
            {Productivity.Task.label(:status, "IN-PROCESS"), "IN-PROCESS"},
            {Productivity.Task.label(:status, "COMPLETED"), "COMPLETED"},
            {Productivity.Task.label(:status, "CANCELLED"), "CANCELLED"}
          ]}
          label="Status"
        />
        <:actions>
          <.button phx-disable-with="Saving...">Save Task</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{task: task} = assigns, socket) do
    changeset = Productivity.change_task(task)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"task" => task_params}, socket) do
    changeset =
      socket.assigns.task
      |> Productivity.change_task(task_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"task" => task_params}, socket) do
    save_task(socket, socket.assigns.action, task_params)
  end

  defp save_task(socket, :edit, task_params) do
    case Productivity.update_task(socket.assigns.task, task_params) do
      {:ok, _task} ->
        {:noreply,
         socket
         |> put_flash(:info, "Task updated successfully")
         |> push_navigate(to: socket.assigns.navigate)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_task(socket, :new, task_params) do
    task_params =
      Map.merge(%{"uid" => UUID.uuid4(), "dtstamp" => DateTime.utc_now()}, task_params)

    case Productivity.create_task(task_params) do
      {:ok, _task} ->
        {:noreply,
         socket
         |> put_flash(:info, "Task created successfully")
         |> push_navigate(to: socket.assigns.navigate)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
