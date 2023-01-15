defmodule ImportantWeb.TaskLive.FormComponent do
  use ImportantWeb, :live_component

  alias Important.Productivity

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
        <.input field={{f, :uid}} type="text" label="Uid" />
        <.input field={{f, :dtstamp}} type="datetime-local" label="Dtstamp" />
        <.input field={{f, :completed}} type="datetime-local" label="Completed" />
        <.input field={{f, :created}} type="datetime-local" label="Created" />
        <.input field={{f, :description}} type="text" label="Description" />
        <.input field={{f, :dtstart}} type="datetime-local" label="Dtstart" />
        <.input field={{f, :due}} type="datetime-local" label="Due" />
        <.input field={{f, :last_modifier}} type="datetime-local" label="Last modifier" />
        <.input field={{f, :organizer}} type="text" label="Organizer" />
        <.input field={{f, :percent_complete}} type="number" label="Percent complete" />
        <.input field={{f, :priority}} type="number" label="Priority" />
        <.input field={{f, :recurrence_id}} type="datetime-local" label="Recurrence" />
        <.input field={{f, :rrule}} type="text" label="Rrule" />
        <.input field={{f, :sequence}} type="number" label="Sequence" />
        <.input field={{f, :status}} type="text" label="Status" />
        <.input field={{f, :summary}} type="text" label="Summary" />
        <.input field={{f, :url}} type="text" label="Url" />
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
