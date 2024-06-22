defmodule ImportantWeb.Components.WeekTimeline do
  use Phoenix.Component

  def week_timeline(assigns) do
    ~H"""
    <div class="flex flex-auto">
      <div class="sticky left-0 z-10 w-14 flex-none bg-white ring-1 ring-gray-100"></div>
      <div class="grid flex-auto grid-cols-1 grid-rows-1">
        <!-- Horizontal lines -->
        <div
          class="col-start-1 col-end-2 row-start-1 grid divide-y divide-gray-100"
          style="grid-template-rows: repeat(48, minmax(3.5rem, 1fr))"
        >
          <div class="row-end-1 h-7"></div>
          <.hour_row time="12AM" />
          <.hour_row time="1AM" />
          <.hour_row time="2AM" />
          <.hour_row time="3AM" />
          <.hour_row time="4AM" />
          <.hour_row time="5AM" />
          <.hour_row time="6AM" />
          <.hour_row time="7AM" />
          <.hour_row time="8AM" />
          <.hour_row time="9AM" />
          <.hour_row time="10AM" />
          <.hour_row time="11AM" />
          <.hour_row time="12PM" />
          <.hour_row time="1PM" />
          <.hour_row time="2PM" />
          <.hour_row time="3PM" />
          <.hour_row time="4PM" />
          <.hour_row time="5PM" />
          <.hour_row time="6PM" />
          <.hour_row time="7PM" />
          <.hour_row time="8PM" />
          <.hour_row time="9PM" />
          <.hour_row time="10PM" />
          <.hour_row time="11PM" />
        </div>
        <!-- Vertical lines -->
        <div class="col-start-1 col-end-2 row-start-1 hidden grid-cols-7 grid-rows-1 divide-x divide-gray-100 sm:grid sm:grid-cols-7">
          <div class="col-start-1 row-span-full"></div>
          <div class="col-start-2 row-span-full"></div>
          <div class="col-start-3 row-span-full"></div>
          <div class="col-start-4 row-span-full"></div>
          <div class="col-start-5 row-span-full"></div>
          <div class="col-start-6 row-span-full"></div>
          <div class="col-start-7 row-span-full"></div>
          <div class="col-start-8 row-span-full w-8"></div>
        </div>
        <!-- Events -->
        <ol
          class="col-start-1 col-end-2 row-start-1 grid grid-cols-1 sm:grid-cols-7 sm:pr-8"
          style="grid-template-rows: 1.75rem repeat(288, minmax(0, 1fr)) auto"
        >
          <.event_block
            dtstart={DateTime.new!(~D[2022-01-12], ~T[06:00:00.000], "Etc/UTC")}
            duration={3600}
            summary="Breakfast"
            color="blue"
          />
          <.event_block
            dtstart={DateTime.new!(~D[2022-01-12], ~T[07:30:00.000], "Etc/UTC")}
            duration={9000}
            summary="Flight to Paris"
            color="pink"
          />
          <.event_block
            dtstart={DateTime.new!(~D[2022-01-15], ~T[10:00:00.000], "Etc/UTC")}
            duration={7200}
            summary="Meeting with design team at Disney"
            color="gray"
          />
        </ol>
      </div>
    </div>
    """
  end

  attr(:time, :string, doc: "The time to display")

  defp hour_row(assigns) do
    ~H"""
    <div>
      <div class="sticky left-0 z-20 -ml-14 -mt-2.5 w-14 pr-2 text-right text-xs leading-5 text-gray-400">
        <%= @time %>
      </div>
    </div>
    <div></div>
    """
  end

  attr(:dtstart, DateTime, doc: "The start time of the event")
  attr(:duration, :integer, doc: "The duration of the event")
  attr(:summary, :string, doc: "The summary of the event")
  attr(:description, :string, doc: "The description of the event")
  attr(:color, :string, doc: "The color of the event")

  def event_block(assigns) do
    ~H"""
    <li
      class={"relative mt-px hidden sm:col-start-#{day_column(@dtstart)} sm:flex"}
      style={"grid-row: #{time_offset(@dtstart)} / span #{duration_span(@duration)}"}
    >
      <a
        href="#"
        class={"group absolute inset-1 flex flex-col overflow-y-auto rounded-lg bg-#{@color}-50 p-2 text-xs leading-5 hover:bg-#{@color}-100"}
      >
        <p class={"order-1 font-semibold text-#{@color}-700"}><%= @summary %></p>
        <p class={"text-#{@color}-500 group-hover:text-#{@color}-700"}>
          <time datetime={Timex.format!(@dtstart, "{YYYY}-{0M}-{0D}T{h24}:{m}")}>
            <%= Timex.format!(@dtstart, "{h12}:{m} {AM}") %>
          </time>
        </p>
      </a>
    </li>
    """
  end

  defp day_column(dtstart) do
    Timex.weekday(dtstart)
  end

  defp time_offset(dtstart) do
    floor(Timex.diff(dtstart, dtstart |> Timex.beginning_of_day(), :minutes) / 5) + 2
  end

  defp duration_span(duration) do
    floor(duration / 60 / 5)
  end
end
