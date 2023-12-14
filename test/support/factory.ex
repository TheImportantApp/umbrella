defmodule Important.Factory do
  use ExMachina

  def task_factory do
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
