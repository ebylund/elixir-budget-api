defmodule BudgetApi.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :date, :date
      add :description, :string
      add :category, :string
      add :amount, :float

      timestamps()
    end

  end
end
