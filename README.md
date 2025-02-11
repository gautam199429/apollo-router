# Enforcing Client Identification Headers via Rhai Scripting

This example repo provides a minimal demonstration of using a Rhai script to validate that incoming requests contain the `apollographql-client-name` and `apollographql-client-version` headers used for metrics collection with GraphOS.

## Running the Example

1. Run the subgraph from the `/subgraph` directory with `npm run dev`
2. In the `/router` directory, download the router by running `./download_router.sh`
3. In the `/router` directory, compose the schema by running `./create_local_schema.sh`
4. In the `/router` directory, run the router by running `./start_router.sh`

Now if you run this code in the browser (http://127.0.0.1:4000/), you can send through a graphql request and observe that without the client headers, an error will be thrown. Note that this example also enforces the client name to be `apollo-client` or `retail-website`.

## Code Highlights

The most notable portion of this code is found in the `/router` directory. In the router-config.yaml, rhai scripts are enabled and it points to the `rhai/main.rhai` script as the entry point.
