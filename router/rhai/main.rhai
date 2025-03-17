import "client_id" as client_id;

fn process_request(request) {
    client_id::process_request(request);
}

fn subgraph_service(service, subgraph) {
    const request_callback = Fn("process_request"); 
    service.map_request(request_callback);
}



// service:My-Graph-irazll:w_BEPyF--QyK3JF-jFhUFQ
