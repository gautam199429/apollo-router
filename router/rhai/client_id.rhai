import "config" as config;

fn process_request(request) {
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
            let blocks = processQueryAndGetName(query);
            let bypass_list_ent = #{};
            let isEntitlemnetValue = "True";
            for queryName in blocks {
                let isEntitlemnet = is_bypass(queryName,client_id);
                if !isEntitlemnet {
                    isEntitlemnetValue = "False";
                    break;
                }
            }
            request.context["ENTITLEMENTS_BYPASS"] = isEntitlemnetValue; 
            // request.headers["ENTITLEMENTS_BYPASS"] = isEntitlemnetValue;
          }
    }
    else{
        throw #{
            status: 401,
            message: "client-Id header is required"
          };
    }
}

fn processQueryAndGetName(input){
    let first_index_of_middle_braket = input.index_of("{");
    let last_index_of_middle_braket = find_brace_positions(input);
    let length = last_index_of_middle_braket - first_index_of_middle_braket;
    let query_name = input.sub_string(first_index_of_middle_braket + 1, length - 1);
    let blocks = [];
    let lines = query_name.split("\n");
    let current_block = "";
    let brace_count = 0;
    let in_block = false;

    for line in lines {
        line.trim();
        // Check for the start of a block
        if line.contains("{") {
            in_block = true;
            brace_count += count_char(line, '{');
        }
        
        if in_block {
            current_block += line + "\n";
            // Count opening and closing braces
            brace_count -= count_char(line, '}');
            
            // If brace count is zero, the current block is complete
            if brace_count == 0 {
                let result = processQuery(current_block);
                blocks.push(result);
                current_block = "";
                in_block = false;
            }
        }
    }
    return blocks;
}


fn processQuery(block){
    let small_bracket_start = block.index_of("(");
    if small_bracket_start > 0{
        let query_name_bcr = block.sub_string(0, small_bracket_start);
        query_name_bcr.trim();
        return query_name_bcr;
    }
    else{
        let middle_bracket_start = block.index_of("{");
        let query_name_bcr = block.sub_string(0, middle_bracket_start);
        query_name_bcr.trim();
        return query_name_bcr;
    }
}

fn count_char(input, char_to_count) {
    let count = 0;
    for ch in input.chars() {
        if ch == char_to_count {
            count += 1;
        }
    }
    return count;
}


fn find_brace_positions(input) {
    let last_index = -1;
    let i = input.len() - 1;
    while i >= 0 {
        if input[i] == '}' {
            last_index = i;
            break;
        }
        i -= 1;
    }
    return last_index;
}


fn is_bypass(query_name, client_id) {
    let bypass_list = config::bypass_list;
    let query_key = `${query_name}_${client_id}`;
    return bypass_list[query_key] ?? false;
}