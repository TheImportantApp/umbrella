defmodule ImportantWeb.Components do
  defmacro __using__(_) do
    quote do
      import ImportantWeb.Components.{
        DayCalendarHeader,
        DayTimeline,
        DayTimelineHeader,
        MiniCalendar,
        WeekCalendarHeader,
        WeekTimeline,
        WeekTimelineHeader
      }
    end
  end
end
