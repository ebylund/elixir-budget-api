defmodule BudgetApi.Repo do
  use Ecto.Repo,
    otp_app: :budget_api,
    adapter: Ecto.Adapters.Postgres
end
