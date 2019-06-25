defmodule BudgetApi.BudgetPi.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  schema "transactions" do
    field :amount, :float
    field :category, :string
    field :date, :date
    field :description, :string

    timestamps()
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:date, :description, :category, :amount])
    |> validate_required([:date, :description, :category, :amount])
  end
end
