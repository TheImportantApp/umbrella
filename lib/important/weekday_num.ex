defmodule Important.WeekdayNum do
  def new(attrs) do
    {occurrence, attrs} = Keyword.pop(attrs, :occurrence)
    {weekday, _attrs} = Keyword.pop(attrs, :weekday)

    %{
      occurrence: occurrence,
      weekday: weekday
    }
  end
end
