defmodule BudgetApiWeb.TransactionController do
  use BudgetApiWeb, :controller

  alias BudgetApi.BudgetPi
  alias BudgetApi.BudgetPi.Transaction

  action_fallback BudgetApiWeb.FallbackController

  def index(conn, _params) do
    transactions = BudgetPi.list_transactions()
    :timer.sleep(1500)
    render(conn, "index.json", transactions: transactions)
  end

  def create(conn, %{"transaction" => transaction_params}) do
    with {:ok, %Transaction{} = transaction} <- BudgetPi.create_transaction(transaction_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.transaction_path(conn, :show, transaction))
      |> render("show.json", transaction: transaction)
    end
  end

  def show(conn, %{"id" => id}) do
    transaction = BudgetPi.get_transaction!(id)
    render(conn, "show.json", transaction: transaction)
  end

  def update(conn, %{"id" => id, "transaction" => transaction_params}) do
    transaction = BudgetPi.get_transaction!(id)

    with {:ok, %Transaction{} = transaction} <- BudgetPi.update_transaction(transaction, transaction_params) do
      render(conn, "show.json", transaction: transaction)
    end
  end

  def delete(conn, %{"id" => id}) do
    transaction = BudgetPi.get_transaction!(id)

    with {:ok, %Transaction{}} <- BudgetPi.delete_transaction(transaction) do
      send_resp(conn, :no_content, "")
    end
  end

  defp csv_content do
    [['a', 'list'],['of', 'lists']]
                  |> CSV.encode
                  |> Enum.to_list
                  |> to_string
  end

  def export(conn, _params) do
    conn
    |> put_resp_content_type("text/csv")
    |> put_resp_header("content-disposition", "attachment; filename=\"transactions.csv\"")
    |> send_resp(200, csv_content())
  end

  def import(conn, %{"transactions-file" => trans_props}) do
#    put_resp_header(conn, "Access-Control-Allow-Origin", "*")
    trans_props.path
    |> File.stream!
    |> CSV.decode!(headers: true)
    |> Enum.each(fn (transaction) -> BudgetPi.create_transaction(transaction) end)

    send_resp(conn, :no_content, "")
  end

end
