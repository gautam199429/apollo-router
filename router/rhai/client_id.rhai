fn process_request(request) {
  print("Supergraph service: Client request received"); 
  let query = request.body.query;
  let query_name = process_Query(query);
  throw #{
    status: 401,
    message: query_name
  };
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