defmodule ImportantWeb.Components do
  defmacro __using__(_) do
    quote do
      import ImportantWeb.Components.{
        MiniCalendar
      }
    end
  end
end
