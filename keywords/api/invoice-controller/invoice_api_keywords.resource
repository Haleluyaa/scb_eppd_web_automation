***Keywords***
########################################################################################################################
# KEYWORD LEVEL 1 : To Support BDD style
# PLEASE DO
#   1. Passing parameter in keyword's name, then pass it to keyword level 2.
#
# PLEASE DO NOT 
#   1. Access any LOCATOR.
#   2. Access any VARIABLE directly.
########################################################################################################################
Delete draft invoice from "${endpoint}" at uri "${uri}" via "${supplier_mpid}" and "${invoice_num}"
    [Documentation]    Delete draft invoice via api to delete method

    ${invoice_id_list}    Get invoice id draft from database    ${supplier_mpid}    ${invoice_num}
    Run Keyword If    @{invoice_id_list}!=@{EMPTY}    Delete draft invoice via invoice id    ${endpoint}    ${uri}    ${invoice_id_list}

Create invoice post request data to "${endpoint}" at uri "${uri}" via "${data_template}" with "${test_data}"    
    [Documentation]    Create invoice via api to post method

    ${dictionary_template}  Load yaml template to dictionary  ${data_template}
    ${dictionary_key}  Get key from dictionary  ${dictionary_template}  
    ${request_data}    Update invoice dictionary value to template from expected data    ${dictionary_template}    ${dictionary_key}    ${test_data}
    ${create_creditdebit_note_response}    Post request data for supplier user TT00100  ${endpoint}  ${uri}  ${request_data}

Get invoice from elastic search via portal api on invoice "${invoice_num}" from supplier "${supplier_mpid}" from endpoint "${endpoint}", uri "${uri}"

    ${invoice_id}    Get invoice id via supplier mpid and invoice number    ${supplier_mpid}    ${invoice_num}
    ${response}    Get invoice from elastic search  ${endpoint}  ${uri}  ${invoice_id}[0][0]

    [Return]    ${response}




########################################################################################################################
# KEYWORD LEVEL 2 : Micro keyword
# PLEASE DO
#   1. Always keep it do small action.
#   2. Access LOCATOR.
#   3. Passing parameter by using [Arguments] tag
#
# PLEASE DO NOT 
#   1. Access any VARIABLE directly. (Allow only ${TIMEOUT})
########################################################################################################################
Get invoice id draft from database
    [Arguments]    ${supplier_mpid}    ${invoice_num}

    @{response}    Get invoice id draft via supplier mpid and invoice number    ${supplier_mpid}    ${invoice_num}

    [Return]    @{response}

Get invoice from elastic search
    [Arguments]    ${endpoint}    ${uri}    ${invoice_id}

    ${params}    Set Variable    invoiceID=${invoice_id}
    ${response}    Get request data with param and header torken   ${endpoint}    ${uri}    ${params}    

    [Return]    ${response}



Delete draft invoice via invoice id
    [Arguments]    ${endpoint}    ${uri}    ${invoice_id_list}   

    ${length}    Get Length    ${invoice_id_list}  

    FOR    ${index}    IN   0    ${length-1}
        Delete request data  ${endpoint}  ${uri}  ${invoice_id_list}[${index}][0]
    END 

Update invoice dictionary value to template from expected data
    [Arguments]    ${source_dict}    ${replace_dict_key}    ${replace_dict_val}
    ${replace_invoice_num}    Generate invoice number to api
    ${new_request_data}    Update dictionary value  ${source_dict}    ${replace_dict_key}    ${replace_dict_val}
    ${destination_data}    Replace invoice num     ${new_request_data}    ${replace_invoice_num}

    [Return]    ${destination_data}

Generate invoice number to api
    Generate invoice number    VAL
    ${TV_invoice_num_api}    Set Variable    ${TV_gen_invoice_num}

    Set Test Variable    ${TV_invoice_num_api}
    [Return]    ${TV_invoice_num_api}

Replace invoice num 
    [Arguments]    ${source_dict}    ${replace_invoice_num}

    Set To Dictionary    ${source_dict['invoices'][0]}    invoiceNum    ${replace_invoice_num}     

    [Return]    ${source_dict}     

Generate invoice number   
    [Arguments]    ${prefix}=DR_   
    [Documentation]    Generate draft invoice number in format

    ${current_date}    Get current date in format 'dd/MM/yyyy HH-mm'

    ${current_date}    Convert Date    ${current_date}    result_format=%d/%m/%Y %H:%M   date_format=%d/%m/%Y %H:%M
    ${prefix}    Set Variable    ${prefix}
    
    ${invoice_num}    Set Variable    ${prefix}${current_date}
    ${TV_gen_invoice_num}    Set Variable    ${invoice_num}

    Set Test Variable    ${TV_gen_invoice_num}        







