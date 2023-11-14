*** Keywords ***

########################################################################################################################
# KEYWORD LEVEL 1 : To Support BDD style
# PLEASE DO
#   1. Passing parameter in keyword's name, then pass it to keyword level 2.
#
# PLEASE DO NOT 
#   1. Access any LOCATOR.
#   2. Access any VARIABLE directly.
########################################################################################################################
Prepare post request data to "${ENDPOINT}" at uri "${URI}" via "${data_template}" with "${test_data}"
    
    #Prepared cndn data for approved 
    ${dictionary_template}  Load yaml template to dictionary  ${data_template}
    ${dictionary_key}  Get key from dictionary  ${dictionary_template}  
    ${request_data}    Update dictionary value to template from expected data    ${dictionary_template}    ${dictionary_key}    ${test_data}
    #${var_request_json}  Load dictionary to json format  ${dictionary_template}
    ${var_request_json}  Load dictionary to json format  ${request_data}
    ${create_creditdebit_note_response}    Post request data for supplier user TT00100  ${ENDPOINT}  ${URI}  ${var_request_json}

Prepare post request data for elastic to "${ENDPOINT}" at uri "${URI}" via "${data_template}" with "${test_data}"
    ${dictionary_template}  Load yaml template to dictionary  ${data_template}
    ${dictionary_key}  Get key from dictionary  ${dictionary_template}
    ${dictionary_template}    Replace dictionary value for supplier credit/debit note elastic    ${test_data}    ${dictionary_template}
    ${var_request_json}  Load dictionary to json format  ${dictionary_template}    
    #${var_request_json}  Load dictionary to json format  ${var_request_json}
    ${create_creditdebit_note_response}    Post request data for supplier user TT00100  ${ENDPOINT}  ${URI}  ${var_request_json}

Clear prepare cndn data session
    Delete All Cookies 
    Close browser

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
Update dictionary value to template from expected data
    [Arguments]    ${source_dict}    ${replace_dict_key}    ${replace_dict_val}
    
    ${new_request_data}    Update dictionary value  ${source_dict}    ${replace_dict_key}    ${replace_dict_val}

    ${destination_data}    Replace dictionary value for supplier credit/debit note    ${new_request_data}
    
    Return From Keyword    ${destination_data}

Replace dictionary value for supplier credit/debit note
    [Arguments]    ${source_dict}
    
    
    ${credit_note_length}    Get Length    ${source_dict['creditNote']}

    #Loop for replace cndn number and cndn date and tax cndn number and tax cndn date
    :FOR    ${index}    IN RANGE  ${credit_note_length}
          
        Prepared cndn data for approved    ${index}

        ${cndn_list}    Get From List    ${source_dict['creditNote']}    ${index}

        ${cndn_list}    Replace Variables in YAML file    ${cndn_list}
        ${cndn_dict}    Convert To Dictionary    ${cndn_list}
        ${cndn_dict}    Evaluate    [${cndn_dict}]

        Set To Dictionary    ${source_dict}    creditNote    ${cndn_dict}
    END

    [Return]    ${source_dict}

Replace dictionary value for supplier credit/debit note elastic
    [Arguments]    ${source_dict}    ${destination_dict}

    Get invoice remaining on invoice number    ${source_dict.invoiceNum}

    ${elastic_list}    Replace Variables in YAML file     ${source_dict}

    [Return]    ${elastic_list}

Prepared cndn data for approved
    [Arguments]    ${cndn_line_num}

    ${cndn_prefix}    Set Variable    APP
    ${cndn_center}    Evaluate   '{curr_date.year}{curr_date.month}{curr_date.day}{curr_date.hour}{curr_date.minute}'.format(curr_date=datetime.datetime.now())    modules=datetime
    ${cndn_postfix}    Evaluate   '{curr_date.second}'.format(curr_date=datetime.datetime.now())    modules=datetime

    ${cndn_tax_prefix}    Set Variable    TXN
    ${current_date}    Evaluate    '{curr_date.year}-{curr_date.month}-{curr_date.day}'.format(curr_date=datetime.datetime.now())    modules=datetime

    ${preparecndn_num}    Set Variable    ${cndn_prefix}${cndn_center}${cndn_postfix}/${cndn_line_num}
    ${prepare_cndn_date}    Set Variable    ${current_date}
    ${preparetaxcndn_num}    Set Variable    ${cndn_tax_prefix}${cndn_center}
    ${prepare_taxcndn_date}    Set Variable    ${current_date}  

    Set Test Variable    ${preparecndn_num}
    Set Test Variable    ${prepare_cndn_date}
    Set Test Variable    ${preparetaxcndn_num}
    Set Test Variable    ${prepare_taxcndn_date} 

Get invoice remaining on invoice number
    [Arguments]    ${invoice_number}

    ${query_string}    Preparetion query get invoice remaing for amount after create cndn    ${invoice_number}
    ${remaining_invoice}    eInvoice Execute SELECT query string    ${query_string}  

    ${regexp_pattern_remaining_amt}    Set Variable    [-+]?([0-9]*\.[0-9]+|[0-9]+)
    ${remaining_list_like}    Get Regexp Matches    "${remaining_invoice}"   ${regexp_pattern_remaining_amt}   1

    ${remaining_invoice1}    Get From List    ${remaining_list_like}    0
    ${remaining_invoice2}    Get From List    ${remaining_list_like}    1
    ${remaining_invoice1}    Remove unwant strings  ${remaining_invoice1}  '
    

    ${remaining_invoice}    Evaluate    ${remaining_invoice1}${remaining_invoice2}

    Set Test Variable      ${remaining_invoice}

 


