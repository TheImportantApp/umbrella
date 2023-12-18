defmodule ImportantWeb.CalendarLive do
  use ImportantWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="h-screen">
      <div class="flex h-full flex-col">
        <.calendar_header />
        <div class="isolate flex flex-auto overflow-hidden bg-white">
          <div class="flex flex-auto flex-col overflow-auto">
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
end
