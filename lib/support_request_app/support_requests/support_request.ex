defmodule SupportRequests.SupportRequest do
  use Ecto.Schema
  import Ecto.Changeset

  schema "support_requests" do
    field :user, :string
    field :description, :string
    field :acceptance, :string
    field :summary, :string
    field :team, :string
    field :urgency, :string
  end

  def changeset(data) do
    %__MODULE__{}
      |> cast(data, [:user, :description, :acceptance, :summary, :team, :urgency])
  end
end
