defmodule BudgetApiWeb.PageController do
  use BudgetApiWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
