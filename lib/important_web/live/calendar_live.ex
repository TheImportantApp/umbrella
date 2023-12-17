defmodule ImportantWeb.CalendarLive do
  use ImportantWeb, :live_view

  def render(assigns) do
    ~H"""
    <.mini_calendar year={2023} month={12} selected_date={Date.new!(2023, 12, 14)} week_start_day={1} />
    """
  end
end
