defmodule Important.RecurrenceRule do
  def new(attrs) do
    # The FREQ rule part is REQUIRED,
    # but MUST NOT occur more than once.
    {freq, attrs} = Keyword.pop(attrs, :freq)

    # The UNTIL or COUNT rule parts are OPTIONAL,
    # but they MUST NOT occur in the same 'recur'.
    {until, attrs} = Keyword.pop(attrs, :until)
    {count, attrs} = Keyword.pop(attrs, :count)

    # The other rule parts are OPTIONAL,
    # but MUST NOT occur more than once.
    {interval, attrs} = Keyword.pop(attrs, :interval)
    {byday, attrs} = Keyword.pop(attrs, :byday)
    {bymonthday, _attrs} = Keyword.pop(attrs, :bymonthday)

    %{
      freq: freq,
      until: until,
      count: count,
      interval: interval,
      byday: byday,
      bymonthday: bymonthday
    }
  end
end
