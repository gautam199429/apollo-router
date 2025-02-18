import fs from "fs";
import path from "path";
import { ApolloServer } from "@apollo/server";
import { startStandaloneServer } from "@apollo/server/standalone";
import { buildSubgraphSchema } from "@apollo/subgraph";
import { parse } from "graphql";
import { mergeTypeDefs } from "@graphql-tools/merge";
import customerresolvers from "./customerresolvers.js";
import accountresolvers from "./accounsresolver.js";


const resolvers = {
  Query: {
    ...accountresolvers.Query,
    ...customerresolvers.Query,
  }
};

// Load and merge multiple schema files
const schemaFiles = fs
  .readdirSync(path.resolve("src/schema"))
  .filter((file) => path.extname(file) === ".graphql")
  .map((file) => fs.readFileSync(path.resolve("src/schema", file), "utf-8"));

const mergedTypeDefs = mergeTypeDefs(schemaFiles.map((schema) => parse(schema)));

// Build the schema with the merged type definitions and resolvers
const server = new ApolloServer({
  schema: buildSubgraphSchema({ typeDefs: mergedTypeDefs, resolvers }),
});

const { url } = await startStandaloneServer(server, {
  listen: { port: 4001 },
});

console.log(`🚀Server ready at: ${url}`);
