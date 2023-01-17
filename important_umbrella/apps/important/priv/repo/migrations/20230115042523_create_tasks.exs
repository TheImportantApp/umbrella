defmodule Important.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :uid, :text
      add :dtstamp, :utc_datetime
      add :completed, :utc_datetime
      add :created, :utc_datetime
      add :description, :text
      add :dtstart, :utc_datetime
      add :due, :utc_datetime
      add :last_modified, :utc_datetime
      add :organizer, :text
      add :percent_complete, :integer
      add :priority, :integer
      add :recurrence_id, :utc_datetime
      add :rrule, :text
      add :sequence, :integer
      add :status, :text
      add :summary, :text
      add :url, :text

      timestamps()
    end
  end
end
