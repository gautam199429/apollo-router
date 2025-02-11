const resolvers = {
  Query: {
    accountSummary: () => {
      // This would be replaced with logic to fetch account summary data
      return {
        accounts: [
          {
            accountReferenceId: "123456",
            availableCreditAmount: {
              availableSpendingCreditAmount: 5000.00,
              availableCashCreditAmount: 1000.00
            }
          },
          {
            accountReferenceId: "789012",
            availableCreditAmount: {
              availableSpendingCreditAmount: 3000.00,
              availableCashCreditAmount: 500.00
            }
          }
        ]
      };
    }
  },

  Account: {
    // This can have more complex logic for each field if necessary
    accountReferenceId: (parent) => parent.accountReferenceId,
    availableCreditAmount: (parent) => parent.availableCreditAmount
  },

  AvailableCreditAmount: {
    availableSpendingCreditAmount: (parent) => parent.availableSpendingCreditAmount,
    availableCashCreditAmount: (parent) => parent.availableCashCreditAmount
  }
};
export default resolvers;
