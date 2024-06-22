defmodule ImportantWeb.Components.WeekTimelineHeader do
  use Phoenix.Component

  def week_timeline_header(assigns) do
    ~H"""
    <div class="sticky top-0 z-30 flex-none bg-white shadow ring-1 ring-black ring-opacity-5 sm:pr-8">
      <div class="grid grid-cols-7 text-sm leading-6 text-gray-500 sm:hidden">
        <button type="button" class="flex flex-col items-center pb-3 pt-2">
          M
          <span class="mt-1 flex h-8 w-8 items-center justify-center font-semibold text-gray-900">
            10
          </span>
        </button>
        <button type="button" class="flex flex-col items-center pb-3 pt-2">
          T
          <span class="mt-1 flex h-8 w-8 items-center justify-center font-semibold text-gray-900">
            11
          </span>
        </button>
        <button type="button" class="flex flex-col items-center pb-3 pt-2">
          W
          <span class="mt-1 flex h-8 w-8 items-center justify-center rounded-full bg-indigo-600 font-semibold text-white">
            12
          </span>
        </button>
        <button type="button" class="flex flex-col items-center pb-3 pt-2">
          T
          <span class="mt-1 flex h-8 w-8 items-center justify-center font-semibold text-gray-900">
            13
          </span>
        </button>
        <button type="button" class="flex flex-col items-center pb-3 pt-2">
          F
          <span class="mt-1 flex h-8 w-8 items-center justify-center font-semibold text-gray-900">
            14
          </span>
        </button>
        <button type="button" class="flex flex-col items-center pb-3 pt-2">
          S
          <span class="mt-1 flex h-8 w-8 items-center justify-center font-semibold text-gray-900">
            15
          </span>
        </button>
        <button type="button" class="flex flex-col items-center pb-3 pt-2">
          S
          <span class="mt-1 flex h-8 w-8 items-center justify-center font-semibold text-gray-900">
            16
          </span>
        </button>
      </div>

      <div class="-mr-px hidden grid-cols-7 divide-x divide-gray-100 border-r border-gray-100 text-sm leading-6 text-gray-500 sm:grid">
        <div class="col-end-1 w-14"></div>
        <div class="flex items-center justify-center py-3">
          <span>
            Mon <span class="items-center justify-center font-semibold text-gray-900">10</span>
          </span>
        </div>
        <div class="flex items-center justify-center py-3">
          <span>
            Tue <span class="items-center justify-center font-semibold text-gray-900">11</span>
          </span>
        </div>
        <div class="flex items-center justify-center py-3">
          <span class="flex items-baseline">
            Wed
            <span class="ml-1.5 flex h-8 w-8 items-center justify-center rounded-full bg-indigo-600 font-semibold text-white">
              12
            </span>
          </span>
        </div>
        <div class="flex items-center justify-center py-3">
          <span>
            Thu <span class="items-center justify-center font-semibold text-gray-900">13</span>
          </span>
        </div>
        <div class="flex items-center justify-center py-3">
          <span>
            Fri <span class="items-center justify-center font-semibold text-gray-900">14</span>
          </span>
        </div>
        <div class="flex items-center justify-center py-3">
          <span>
            Sat <span class="items-center justify-center font-semibold text-gray-900">15</span>
          </span>
        </div>
        <div class="flex items-center justify-center py-3">
          <span>
            Sun <span class="items-center justify-center font-semibold text-gray-900">16</span>
          </span>
        </div>
      </div>
    </div>
    """
  end
end
