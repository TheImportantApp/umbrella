defmodule ImportantWeb.Components.DayTimeline do
  use Phoenix.Component

  def day_timeline(assigns) do
    ~H"""
    <div class="flex w-full flex-auto">
      <div class="w-14 flex-none bg-white ring-1 ring-gray-100"></div>
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
        <!-- Events -->
        <ol
          class="col-start-1 col-end-2 row-start-1 grid grid-cols-1"
          style="grid-template-rows: 1.75rem repeat(288, minmax(0, 1fr)) auto"
        >
          <li class="relative mt-px flex" style="grid-row: 74 / span 12">
            <a
              href="#"
              class="group absolute inset-1 flex flex-col overflow-y-auto rounded-lg bg-blue-50 p-2 text-xs leading-5 hover:bg-blue-100"
            >
              <p class="order-1 font-semibold text-blue-700">Breakfast</p>
              <p class="text-blue-500 group-hover:text-blue-700">
                <time datetime="2022-01-22T06:00">6:00 AM</time>
              </p>
            </a>
          </li>
          <li class="relative mt-px flex" style="grid-row: 92 / span 30">
            <a
              href="#"
              class="group absolute inset-1 flex flex-col overflow-y-auto rounded-lg bg-pink-50 p-2 text-xs leading-5 hover:bg-pink-100"
            >
              <p class="order-1 font-semibold text-pink-700">Flight to Paris</p>
              <p class="order-1 text-pink-500 group-hover:text-pink-700">
                John F. Kennedy International Airport
              </p>
              <p class="text-pink-500 group-hover:text-pink-700">
                <time datetime="2022-01-22T07:30">7:30 AM</time>
              </p>
            </a>
          </li>
          <li class="relative mt-px flex" style="grid-row: 134 / span 18">
            <a
              href="#"
              class="group absolute inset-1 flex flex-col overflow-y-auto rounded-lg bg-indigo-50 p-2 text-xs leading-5 hover:bg-indigo-100"
            >
              <p class="order-1 font-semibold text-indigo-700">Sightseeing</p>
              <p class="order-1 text-indigo-500 group-hover:text-indigo-700">Eiffel Tower</p>
              <p class="text-indigo-500 group-hover:text-indigo-700">
                <time datetime="2022-01-22T11:00">11:00 AM</time>
              </p>
            </a>
          </li>
        </ol>
      </div>
    </div>
    """
  end

  attr(:time, :string, doc: "The time to display")

  defp hour_row(assigns) do
    ~H"""
    <div>
      <div class="-ml-14 -mt-2.5 w-14 pr-2 text-right text-xs leading-5 text-gray-400">
        <%= @time %>
      </div>
    </div>
    <div></div>
    """
  end

  attr(:dtstart, :string, doc: "The start time of the event")
  attr(:duration, :string, doc: "The duration of the event")
  attr(:summary, :string, doc: "The summary of the event")
  attr(:description, :string, doc: "The description of the event")
  attr(:color, :string, doc: "The color of the event")

  def event_block(assigns) do
    ~H"""
    <li class="relative mt-px flex" style="grid-row: 134 / span 18">
      <a
        href="#"
        class="group absolute inset-1 flex flex-col overflow-y-auto rounded-lg bg-indigo-50 p-2 text-xs leading-5 hover:bg-indigo-100"
      >
        <p class="order-1 font-semibold text-indigo-700"><%= @title %></p>
        <p class="order-1 text-indigo-500 group-hover:text-indigo-700"><%= @description %></p>
        <p class="text-indigo-500 group-hover:text-indigo-700">
          <time datetime="2022-01-22T11:00">11:00 AM</time>
        </p>
      </a>
    </li>
    """
  end
end
