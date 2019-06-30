defmodule BudgetApiWeb.Router do
  use BudgetApiWeb, :router

  pipeline :api do
    plug CORSPlug, origin: "*"
    plug CORSPlug, send_preflight_response?: false
    plug :accepts, ["json"]
  end

  scope "/api", BudgetApiWeb do
    pipe_through :api
    resources "/transactions", TransactionController
    options "/transactions", TransactionController, :options
    options "/transactions/:id", TransactionController, :options

    get "/transactions.csv", TransactionController, :csv_export
    scope "/transactions", as: :upload do
      post "/upload", TransactionController, :import
    end
  end
end
