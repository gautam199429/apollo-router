fn process_request(request) {
  print("Supergraph service: Client request received");
  if ("client-id" in request.headers) {
    let client_id = request.headers["client-id"];
    if client_id == ""{
      throw #{
        status: 401,
        message: "client-id can not be blank"
      };
    }
    else{
      let query = request.body.query;
      let query_name = process_Query(query);
      let entitlement_pass = is_bypass(query_name,client_id);
      if !entitlement_pass{
        throw #{
          status: 200,
          message: "INVALID TYPE"
        };
      }
      else{
        request.context["ENTITLEMENTS_BYPASS"] = entitlement_pass; 
      }
    }
  }
  else{
    throw #{
      status: 401,
      message: "client-Id header is required"
    };
  }
}


fn process_Query(query){
  let first_middle_bracket_start = query.index_of("{");
  let second_middle_bracket_start = query.index_of("{", first_middle_bracket_start + 1);
  let length = second_middle_bracket_start - first_middle_bracket_start;
  let query_name = query.sub_string(first_middle_bracket_start + 1, length - 1);
  let small_bracket_start = query_name.index_of("(");
  if small_bracket_start > 0 {
      let query_name_bcr = query_name.sub_string(0, small_bracket_start);
      query_name_bcr.trim();
      return query_name_bcr;
  }
  else{
      query_name.trim();
      return query_name;
  }
}

fn is_bypass(query_name, client_id) {
  let bypass_list = #{
    "customerById_123": true,
    "dataProducts_123": true,
    "accounts_123": true
  };
  let query_key = `${query_name}_${client_id}`;
  return bypass_list[query_key] ?? false;
}