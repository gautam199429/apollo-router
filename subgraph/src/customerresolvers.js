const customers = [
    {
      name: "GOUTAM KUMAR SAH",
      age: 35,
      accounts: [
        {
          accountReferenceId: "ACC123",
          availableCreditAmount: {
            availableSpendingCreditAmount: 5000.0,
            availableCashCreditAmount: 2000.0,
          },
        },
      ],
    },
    {
      name: "VEER",
      age: 29,
      accounts: [
        {
          accountReferenceId: "ACC456",
          availableCreditAmount: {
            availableSpendingCreditAmount: 7000.0,
            availableCashCreditAmount: 3000.0,
          },
        },
      ],
    },
  ];
  
  const resolvers = {
    Query: {
      customerById: (_, { customerReferenceId }) => {
        return customers.find((customer) => 
          customer.name.toLowerCase() === customerReferenceId.toLowerCase()
        ) || null;
      },
    },
  
    Customer: {
      name: (parent) => parent.name,
      age: (parent) => parent.age,
      accounts: (parent) => parent.accounts,
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