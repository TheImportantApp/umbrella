defmodule ImportantWeb.CalendarLive do
  use ImportantWeb, :live_view

  def render(%{live_action: :day} = assigns) do
    ~H"""
    <div class="h-screen">
      <div class="flex h-full flex-col">
        <.day_calendar_header date={~D[2022-01-22]} />
        <div class="isolate flex flex-auto overflow-hidden bg-white">
          <div class="flex flex-auto flex-col overflow-auto">
            <.day_timeline_header />
            <.day_timeline />
          </div>
          <div class="hidden w-1/2 max-w-md flex-none border-l border-gray-100 px-8 py-10 md:block">
            <.mini_calendar
              year={2023}
              month={12}
              selected_date={Date.new!(2023, 12, 14)}
              week_start_day={1}
            />
          </div>
        </div>
      </div>
    </div>
    """
  end

  def render(%{live_action: :week} = assigns) do
    ~H"""
    <div class="h-screen">
      <div class="flex h-full flex-col">
        <.week_calendar_header />
        <div class="isolate flex flex-auto flex-col overflow-auto bg-white">
          <div
            style="width: 165%"
            class="flex max-w-full flex-none flex-col sm:max-w-none md:max-w-full"
          >
            <.week_timeline_header />
            <.week_timeline />
          </div>
        </div>
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(_params, _uri, socket) do
    {:noreply, socket}
  end
end
