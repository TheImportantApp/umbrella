defmodule Important.TaskStore do
  use Agent

  @default_state %{tasks: []}

  def start(opts) do
    {initial_state, opts} = Keyword.pop(opts, :initial_state, %{})
    Agent.start_link(fn -> Map.merge(@default_state, initial_state) end, opts)
  end

  def get_tasks(store) do
    Agent.get(store, fn state -> state.tasks end)
  end

  defp get_tasks(store, filter) when is_function(filter) do
    Agent.get(store, fn state -> Enum.filter(state.tasks, filter) end)
  end

  def get_tasks_by_categories(store, categories) when is_list(categories) do
    get_tasks(store, fn task ->
      MapSet.subset?(
        MapSet.new(categories),
        MapSet.new(List.wrap(task.categories))
      )
    end)
  end

  def get_tasks_by_datetime_range(store, query_dtstart, query_dtend) do
    get_tasks(store, fn task ->
      case {task.dtstart, task.duration} do
        {nil, _} ->
          false

        {event_dtstart, duration} ->
          event_dtend = Timex.add(event_dtstart, Timex.Duration.parse!(duration))
          event_range = Timex.Interval.new(from: event_dtstart, until: event_dtend)
          query_range = Timex.Interval.new(from: query_dtstart, until: query_dtend)
          Timex.Interval.overlaps?(event_range, query_range)
      end
    end)
  end

  def lookup(name) do
    case Registry.lookup(Important.TaskStoreRegistry, name) do
      [{pid, _}] -> pid
      [] -> start(name: via_registry(name), initial_state: %{tasks: generate_tasks()}) |> elem(1)
    end
  end

  def via_registry(name) do
    {:via, Registry, {Important.TaskStoreRegistry, name}}
  end

  defp generate_tasks() do
    Enum.map(1..100, fn _ -> generate_task() end)
  end

  defp generate_task() do
    uid = Ulid.generate()

    now = DateTime.utc_now()
    created = Faker.DateTime.backward(365)
    last_mod = Faker.DateTime.between(created, now)

    dtstart =
      Faker.DateTime.between(
        DateTime.add(now, -30, :day),
        DateTime.add(now, 30, :day)
      )

    dtend = Faker.DateTime.between(dtstart, DateTime.add(dtstart, 48, :hour))

    completed =
      Faker.DateTime.between(
        DateTime.add(dtstart, -8, :hour),
        DateTime.add(dtend, 8, :hour)
      )

    due =
      Faker.DateTime.between(
        DateTime.add(dtstart, -8, :hour),
        DateTime.add(dtend, 8, :hour)
      )

    duration = Timex.diff(dtend, dtstart, :duration) |> Timex.Duration.to_string()

    picked_dtstart = dtstart |> or_nil()

    Important.Task.new(
      uid: uid,
      class: Faker.Util.pick(["PUBLIC", "PRIVATE", "CONFIDENTIAL"]) |> or_nil(),
      completed: completed |> or_nil(),
      created: created,
      description: Faker.Lorem.paragraph() |> or_nil(),
      dtstart: picked_dtstart,
      last_mod: last_mod |> or_nil(),
      organizer: Faker.Person.name(),
      percent: Faker.Util.pick(0..100) |> or_nil(),
      priority: Faker.Util.pick(0..9) |> or_nil(),
      recurid: nil,
      seq: Faker.Util.pick(0..99) |> or_nil(),
      status:
        Faker.Util.pick(["NEEDS-ACTION", "COMPLETED", "IN-PROCESS", "CANCELLED"]) |> or_nil(),
      summary: Faker.Lorem.sentence(),
      transp: Faker.Util.pick(["OPAQUE", "TRANSPARENT"]) |> or_nil(),
      url: "https://theimportantapp.com/tasks/#{uid}",
      rrule: nil,
      duration:
        if !is_nil(picked_dtstart) do
          duration
        else
          duration |> or_nil()
        end,
      due: due |> or_nil(),
      attachments: nil,
      attendees: nil,
      categories: nil,
      comments: nil,
      exdates: nil,
      rdates: nil
    )
    |> elem(1)
  end

  defp or_nil(value) do
    Faker.Util.pick([value, nil])
  end
end
