const resolvers = {
  Query: {
    accounts: () => [
      {
        accountReferenceId: "ACC001",
        availableCreditAmount: {
          availableSpendingCreditAmount: 2500.75,
          availableCashCreditAmount: 1200.50,
        },
      },
      {
        accountReferenceId: "ACC002",
        availableCreditAmount: {
          availableSpendingCreditAmount: 3400.00,
          availableCashCreditAmount: 1800.00,
        },
      },
    ],
  },

  Account: {
    accountReferenceId: (parent) => parent.accountReferenceId,
    availableCreditAmount: (parent) => parent.availableCreditAmount,
  },

  AvailableCreditAmount: {
    availableSpendingCreditAmount: (parent) => parent.availableSpendingCreditAmount,
    availableCashCreditAmount: (parent) => parent.availableCashCreditAmount,
  },
};

export default resolvers;
