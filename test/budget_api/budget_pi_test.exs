defmodule BudgetApi.BudgetPiTest do
  use BudgetApi.DataCase

  alias BudgetApi.BudgetPi

  describe "transactions" do
    alias BudgetApi.BudgetPi.Transaction

    @valid_attrs %{amount: 120.5, category: "some category", date: ~D[2010-04-17], description: "some description"}
    @update_attrs %{amount: 456.7, category: "some updated category", date: ~D[2011-05-18], description: "some updated description"}
    @invalid_attrs %{amount: nil, category: nil, date: nil, description: nil}

    def transaction_fixture(attrs \\ %{}) do
      {:ok, transaction} =
        attrs
        |> Enum.into(@valid_attrs)
        |> BudgetPi.create_transaction()

      transaction
    end

    test "list_transactions/0 returns all transactions" do
      transaction = transaction_fixture()
      assert BudgetPi.list_transactions() == [transaction]
    end

    test "get_transaction!/1 returns the transaction with given id" do
      transaction = transaction_fixture()
      assert BudgetPi.get_transaction!(transaction.id) == transaction
    end

    test "create_transaction/1 with valid data creates a transaction" do
      assert {:ok, %Transaction{} = transaction} = BudgetPi.create_transaction(@valid_attrs)
      assert transaction.amount == 120.5
      assert transaction.category == "some category"
      assert transaction.date == ~D[2010-04-17]
      assert transaction.description == "some description"
    end

    test "create_transaction/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = BudgetPi.create_transaction(@invalid_attrs)
    end

    test "update_transaction/2 with valid data updates the transaction" do
      transaction = transaction_fixture()
      assert {:ok, %Transaction{} = transaction} = BudgetPi.update_transaction(transaction, @update_attrs)
      assert transaction.amount == 456.7
      assert transaction.category == "some updated category"
      assert transaction.date == ~D[2011-05-18]
      assert transaction.description == "some updated description"
    end

    test "update_transaction/2 with invalid data returns error changeset" do
      transaction = transaction_fixture()
      assert {:error, %Ecto.Changeset{}} = BudgetPi.update_transaction(transaction, @invalid_attrs)
      assert transaction == BudgetPi.get_transaction!(transaction.id)
    end

    test "delete_transaction/1 deletes the transaction" do
      transaction = transaction_fixture()
      assert {:ok, %Transaction{}} = BudgetPi.delete_transaction(transaction)
      assert_raise Ecto.NoResultsError, fn -> BudgetPi.get_transaction!(transaction.id) end
    end

    test "change_transaction/1 returns a transaction changeset" do
      transaction = transaction_fixture()
      assert %Ecto.Changeset{} = BudgetPi.change_transaction(transaction)
    end
  end
end
