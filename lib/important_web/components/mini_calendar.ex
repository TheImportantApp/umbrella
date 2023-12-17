defmodule ImportantWeb.Components.MiniCalendar do
  use Phoenix.Component

  alias PetalComponents.Icon

  attr(:month, :integer, doc: "The month to display")
  attr(:year, :integer, doc: "The year to display")
  attr(:selected_date, :integer, doc: "The date to highlight as selected")
  attr(:week_start_day, :integer, default: 0, doc: "The day of the week to start on")

  def mini_calendar(assigns) do
    ~H"""
    <div class="i-mini-calendar">
      <.month_picker year={@year} month={@month} />
      <.weekdays_header week_start_day={@week_start_day} />
      <.date_grid
        year={@year}
        month={@month}
        selected_date={@selected_date}
        week_start_day={@week_start_day}
      />
    </div>
    """
  end

  defp month_picker(assigns) do
    ~H"""
    <div class="flex items-center text-center text-gray-900">
      <button
        type="button"
        class="-m-1.5 flex flex-none items-center justify-center p-1.5 text-gray-400 hover:text-gray-500"
      >
        <span class="sr-only">Previous month</span>
        <Icon.icon name={:chevron_left} class="h-4 w-4" />
      </button>
      <div class="flex-auto text-sm font-semibold"><%= Timex.month_name(@month) %> <%= @year %></div>
      <button
        type="button"
        class="-m-1.5 flex flex-none items-center justify-center p-1.5 text-gray-400 hover:text-gray-500"
      >
        <span class="sr-only">Next month</span>
        <Icon.icon name={:chevron_right} class="h-4 w-4" />
      </button>
    </div>
    """
  end

  defp weekdays_header(assigns) do
    ~H"""
    <div class="mt-6 grid grid-cols-7 text-center text-xs leading-6 text-gray-500">
      <div :for={day <- get_weekdays(@week_start_day)}>
        <%= String.first(day) |> String.upcase() %>
      </div>
    </div>
    """
  end

  defp get_weekdays(week_start_day) do
    days = ~w(sunday monday tuesday wednesday thursday friday saturday)
    Enum.drop(days, week_start_day) ++ Enum.take(days, week_start_day)
  end

  defp date_grid(assigns) do
    days_in_curr_month = Timex.days_in_month(assigns.year, assigns.month)
    {prev_year, prev_month} = get_prev_month(assigns.year, assigns.month)
    {next_year, next_month} = get_next_month(assigns.year, assigns.month)
    days_in_prev_month = Timex.days_in_month(prev_year, prev_month)
    day_of_first = day_of_week(assigns.year, assigns.month, 1, assigns.week_start_day)

    day_of_last =
      day_of_week(assigns.year, assigns.month, days_in_curr_month, assigns.week_start_day)

    curr_month_range = Range.new(1, days_in_curr_month, 1)
    prev_month_range = Range.new(days_in_prev_month - day_of_first + 1, days_in_prev_month, 1)
    next_month_range = Range.new(1, 6 - day_of_last, 1)

    ~H"""
    <div class="isolate mt-2 grid grid-cols-7 gap-px rounded-lg bg-gray-200 text-sm shadow ring-1 ring-gray-200">
      <.date_cell
        :for={day <- prev_month_range}
        date={Date.new!(prev_year, prev_month, day)}
        selected_date={@selected_date}
        is_current_month={false}
      />
      <.date_cell
        :for={day <- curr_month_range}
        date={Date.new!(@year, @month, day)}
        selected_date={@selected_date}
        is_current_month={true}
      />
      <.date_cell
        :for={day <- next_month_range}
        date={Date.new!(next_year, next_month, day)}
        selected_date={@selected_date}
        is_current_month={false}
      />
    </div>
    """
  end

  defp day_of_week(year, month, day, week_start_day) do
    (Timex.Calendar.Julian.day_of_week(year, month, day, :sun) - week_start_day + 7) |> rem(7)
  end

  defp get_prev_month(year, month) do
    if month == 1 do
      {year - 1, 12}
    else
      {year, month - 1}
    end
  end

  defp get_next_month(year, month) do
    if month == 12 do
      {year + 1, 1}
    else
      {year, month + 1}
    end
  end

  defp date_cell(assigns) do
    is_selected = assigns.selected_date == assigns.date
    is_today = Date.utc_today() == assigns.date

    ~H"""
    <button
      type="button"
      class={[
        "py-1.5 hover:bg-gray-100 focus:z-10",
        get_date_cell_button_bg_classes(@is_current_month),
        get_date_cell_button_font_weight_classes(is_selected || is_today),
        get_date_cell_button_text_color_classes(is_selected, is_today, @is_current_month)
      ]}
    >
      <time
        datetime={Timex.format!(@date, "{YYYY}-{0M}-{0D}")}
        class={[
          "mx-auto flex h-7 w-7 items-center justify-center rounded-full",
          get_date_cell_time_bg_classes(is_selected)
        ]}
      >
        <%= @date.day %>
      </time>
    </button>
    """
  end

  defp get_date_cell_button_bg_classes(true), do: "bg-white"
  defp get_date_cell_button_bg_classes(_), do: "bg-gray-50"
  defp get_date_cell_button_font_weight_classes(true), do: "font-semibold"
  defp get_date_cell_button_font_weight_classes(_), do: nil
  defp get_date_cell_button_text_color_classes(true, _, _), do: "text-white"
  defp get_date_cell_button_text_color_classes(_, true, _), do: "text-indigo-600"
  defp get_date_cell_button_text_color_classes(_, _, true), do: "text-gray-900"
  defp get_date_cell_button_text_color_classes(_, _, _), do: "text-gray-400"
  defp get_date_cell_time_bg_classes(true), do: "bg-gray-900"
  defp get_date_cell_time_bg_classes(_), do: nil
end
