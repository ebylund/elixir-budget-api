defmodule BudgetApiWeb.Router do
  use BudgetApiWeb, :router

  pipeline :api do
    plug CORSPlug, origin: "*"
    plug :accepts, ["json"]
  end

  scope "/api", BudgetApiWeb do
    pipe_through :api
    resources "/transactions", TransactionController

    scope "/transactions", as: :upload do
      get "/upload", TransactionController, :export
      post "/upload", TransactionController, :import
    end
  end
end
