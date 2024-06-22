defmodule ImportantWeb.Components.DayTimelineHeader do
  use Phoenix.Component

  def day_timeline_header(assigns) do
    ~H"""
    <div class="sticky top-0 z-10 grid flex-none grid-cols-7 bg-white text-xs text-gray-500 shadow ring-1 ring-black ring-opacity-5 md:hidden">
      <button type="button" class="flex flex-col items-center pb-1.5 pt-3">
        <span>W</span>
        <!-- Default: "text-gray-900", Selected: "bg-gray-900 text-white", Today (Not Selected): "text-indigo-600", Today (Selected): "bg-indigo-600 text-white" -->
        <span class="mt-3 flex h-8 w-8 items-center justify-center rounded-full text-base font-semibold text-gray-900">
          19
        </span>
      </button>
      <button type="button" class="flex flex-col items-center pb-1.5 pt-3">
        <span>T</span>
        <span class="mt-3 flex h-8 w-8 items-center justify-center rounded-full text-base font-semibold text-indigo-600">
          20
        </span>
      </button>
      <button type="button" class="flex flex-col items-center pb-1.5 pt-3">
        <span>F</span>
        <span class="mt-3 flex h-8 w-8 items-center justify-center rounded-full text-base font-semibold text-gray-900">
          21
        </span>
      </button>
      <button type="button" class="flex flex-col items-center pb-1.5 pt-3">
        <span>S</span>
        <span class="mt-3 flex h-8 w-8 items-center justify-center rounded-full bg-gray-900 text-base font-semibold text-white">
          22
        </span>
      </button>
      <button type="button" class="flex flex-col items-center pb-1.5 pt-3">
        <span>S</span>
        <span class="mt-3 flex h-8 w-8 items-center justify-center rounded-full text-base font-semibold text-gray-900">
          23
        </span>
      </button>
      <button type="button" class="flex flex-col items-center pb-1.5 pt-3">
        <span>M</span>
        <span class="mt-3 flex h-8 w-8 items-center justify-center rounded-full text-base font-semibold text-gray-900">
          24
        </span>
      </button>
      <button type="button" class="flex flex-col items-center pb-1.5 pt-3">
        <span>T</span>
        <span class="mt-3 flex h-8 w-8 items-center justify-center rounded-full text-base font-semibold text-gray-900">
          25
        </span>
      </button>
    </div>
    """
  end
end
