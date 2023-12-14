defprotocol Important.Value do
  @fallback_to_any true
  def to_ics(data)
end

alias Important.Value

defimpl Value, for: DateTime do
  @doc """
  This function converts DateTimes to UTC timezone and then into Strings in the
  iCal format.
  """
  def to_ics(%DateTime{time_zone: "Etc/UTC"} = date) do
    "#{format_datetime(date)}Z"
  end

  def to_ics(%DateTime{} = date) do
    "TZID=#{date.time_zone}:#{format_datetime(date)}"
  end

  defp format_datetime(timestamp) do
    format_string = "{YYYY}{0M}{0D}T{h24}{m}{s}"

    {:ok, result} =
      timestamp
      |> Timex.format(format_string)

    result
  end
end

defimpl Value, for: Date do
  @doc """
  This function converts DateTimes to UTC timezone and then into Strings in the
  iCal format.
  """
  def to_ics(%Date{} = timestamp) do
    format_string = "{YYYY}{0M}{0D}"

    {:ok, result} =
      timestamp
      |> Timex.format(format_string)

    result
  end
end

defimpl Value, for: Any do
  def to_ics(x), do: x
end
