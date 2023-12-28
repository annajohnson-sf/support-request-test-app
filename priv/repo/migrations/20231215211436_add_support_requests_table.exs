defmodule SupportRequestApp.Repo.Migrations.AddSupportRequestsTable do
  use Ecto.Migration

  def change do
    create table(:support_requests) do
      add :user, :string, null: false
      add :description, :string, null: false
      add :acceptance, :string, null: false
      add :summary, :string, null: false
      add :team, :string, null: false
      add :urgency, :string, null: false
    end
  end
end
