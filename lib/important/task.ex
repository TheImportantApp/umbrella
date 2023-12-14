defmodule Important.Task do
  def new(attrs \\ []) do
    # The following are REQUIRED,
    # but MUST NOT occur more than once.
    {uid, attrs} = Keyword.pop(attrs, :uid, Ulid.generate())

    # The following are OPTIONAL,
    # but MUST NOT occur more than once.
    {class, attrs} = Keyword.pop(attrs, :class)
    {completed, attrs} = Keyword.pop(attrs, :completed)
    {created, attrs} = Keyword.pop(attrs, :created)
    {description, attrs} = Keyword.pop(attrs, :description)
    {dtstart, attrs} = Keyword.pop(attrs, :dtstart)
    {last_mod, attrs} = Keyword.pop(attrs, :last_mod)
    {organizer, attrs} = Keyword.pop(attrs, :organizer)
    {percent, attrs} = Keyword.pop(attrs, :percent)
    {priority, attrs} = Keyword.pop(attrs, :priority)
    {recurid, attrs} = Keyword.pop(attrs, :recurid)
    {seq, attrs} = Keyword.pop(attrs, :seq)
    {status, attrs} = Keyword.pop(attrs, :status)
    {summary, attrs} = Keyword.pop(attrs, :summary)
    {transp, attrs} = Keyword.pop(attrs, :transp)
    {url, attrs} = Keyword.pop(attrs, :url)

    # The following is OPTIONAL,
    # but SHOULD NOT occur more than once.
    {rrule, attrs} = Keyword.pop(attrs, :rrule)

    # Either 'dtend' or 'duration' MAY appear in
    # a 'task', but 'dtend' and 'duration'
    # MUST NOT occur in the same 'task'.

    # Note: dtend and duration, in combination with dtstart,
    # represent when the task is worked on.
    {dtend, attrs} = Keyword.pop(attrs, :dtend)
    {duration, attrs} = Keyword.pop(attrs, :duration)

    # Note: The due date is not mutually exclusive
    # with duration as it is in the iCal spec.
    # The due date represents when the organizer intends
    # to complete the task. That is separate from when the
    # task is worked on.
    {due, attrs} = Keyword.pop(attrs, :due)

    # The following are OPTIONAL,
    # and MAY occur more than once.

    # Note: These have been pluralized in cases
    # that their iCal counterparts are singular
    # and they are represented as lists.
    {attachments, attrs} = Keyword.pop(attrs, :attachments)
    {attendees, attrs} = Keyword.pop(attrs, :attendees)
    {categories, attrs} = Keyword.pop(attrs, :categories)
    {comments, attrs} = Keyword.pop(attrs, :comments)
    {exdates, attrs} = Keyword.pop(attrs, :exdates)
    {rdates, _attrs} = Keyword.pop(attrs, :rdates)

    {:ok,
     %{
       uid: uid,
       class: class,
       completed: completed,
       created: created,
       description: description,
       dtstart: dtstart,
       last_mod: last_mod,
       organizer: organizer,
       percent: percent,
       priority: priority,
       recurid: recurid,
       seq: seq,
       status: status,
       summary: summary,
       transp: transp,
       url: url,
       rrule: rrule,
       dtend: dtend,
       duration: duration,
       due: due,
       attachments: attachments,
       attendees: attendees,
       categories: categories,
       comments: comments,
       exdates: exdates,
       rdates: rdates
     }}
  end
end
