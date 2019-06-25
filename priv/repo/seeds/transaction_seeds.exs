alias BudgetApi.Repo
alias BudgetApi.BudgetPi.Transaction

Repo.insert! %Transaction{
  date: ~D[2019-06-20],
  description: "Frei's Fruit Market",
  category: "Groceries",
  amount: 12.38
}

Repo.insert! %Transaction{
  date: ~D[2019-06-21],
  description: "Swig N' Treats",
  category: "Treats",
  amount: 9.31
}

Repo.insert! %Transaction{
  date: ~D[2019-06-22],
  description: "Napa Auto Parts",
  category: "Auto",
  amount: 182.43
}

Repo.insert! %Transaction{
  date: ~D[2019-06-23],
  description: "Little Caesar's Pizza",
  category: "Eating Out",
  amount: 8.65
}

Repo.insert! %Transaction{
  date: ~D[2019-06-23],
  description: "Perks!",
  category: "Treats",
  amount: 6.25
}