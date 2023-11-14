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
Prepare post draft invoice to "${endpoint}" at uri "${uri}" via "${data_template}" and "${test_data}"
    [Documentation]    Support upload invoice api that not in Test Setup
    ${dictionary_template}  Load yaml template to dictionary  ${data_template}
    ${dictionary_key}  Get key from dictionary  ${dictionary_template}
    ${request_data}    Update dictionary value to template from expected data    ${dictionary_template}    ${dictionary_key}    ${test_data}
    ${var_request_json}  Load dictionary to json format  ${request_data}

    ${upload_invoiceresponse}    Post request data   ${ENDPOINT}  ${URI}  ${var_request_json}

Prepare post draft invoice to "${endpoint}" at uri "${uri}" from file "${filename}"
    [Documentation]    Support upload draft invoice support Test Setup

    ${data_template}   Get upload invoice template file path    ${filename}
    ${dictionary_template}  Load yaml template to dictionary  ${data_template}
    ${dictionary_key}  Get key from dictionary  ${dictionary_template}
    ${request_data}    Update dictionary value to dictionary from expected data    ${dictionary_template}    ${dictionary_key}
    ${var_request_json}  Load dictionary to json format  ${request_data}

    ${upload_invoiceresponse}    Post request data   ${ENDPOINT}  ${URI}  ${var_request_json}    


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
Get upload invoice template file path
    [Arguments]    ${file_name}
    [Documentation]    Get relative path from argument files name

    ${target_file_path}     set variable    {CURDIT}/../mockdata_template/upload-invoice-controller/${file_name}
    ${file_path}    Get Canonical Path    ${target_file_path}

    [Return]    ${file_path}


Update dictionary value to template from expected data
    [Arguments]    ${source_dict}    ${replace_dict_key}    ${replace_dict_val}
    [Documentation]    Update data to dictionary over dictionary key

    ${new_request_data}    Update dictionary value  ${source_dict}    ${replace_dict_key}    ${replace_dict_val}

    ${destination_data}    Replace dictionary value for upload invoice data    ${new_request_data}

    [Return]    ${destination_data}

Update dictionary value to dictionary from expected data
    [Arguments]    ${source_dict}    ${replace_dict_key}

    ${destination_data}    Replace dictionary over dictionary key    ${source_dict}

    [Return]    ${destination_data}    

Replace dictionary over dictionary key
    [Arguments]    ${source_dict}

    ${current_date}    Get current date in format 'dd/MM/yyyy'
    Generate invoice number


    ${invoice_num}    Set Variable    ${TV_gen_invoice_num}
    ${invoice_date}    Set Variable    ${current_date}
    ${taxinvoice_date}     Set Variable    ${current_date}

    ${current_date}    Convert Date    ${current_date}    result_format=%d/%m/%Y    date_format=%d/%m/%Y

    ${TV_invoice_num_upload}    Set Variable    ${TV_gen_invoice_num}
    ${TV_invoice_create_date_upload}    Set Variable    ${current_date}
    ${TV_upload_buyer_name}     Get From Dictionary    ${source_dict}    buyerName

    Set Test Variable    ${invoice_num}
    Set Test Variable    ${invoice_date}
    Set Test Variable    ${taxinvoice_date}
    Set Test Variable    ${TV_invoice_num_upload}
    Set Test Variable    ${TV_upload_buyer_name}
    Set Test Variable    ${TV_invoice_create_date_upload}

    Set To Dictionary    ${source_dict['invoices'][0]}    invoiceDate    ${invoice_date}
    Set To Dictionary    ${source_dict['invoices'][0]}    invoiceNum    ${TV_invoice_num_upload}
    Set To Dictionary    ${source_dict['invoices'][0]}    taxInvoiceDate    ${taxinvoice_date}
    Set To Dictionary    ${source_dict['invoices'][0]}    taxInvoiceNumber    ${TV_invoice_num_upload}

    [Return]    ${source_dict}


Replace dictionary value for upload invoice data
    [Arguments]    ${source_dict}
    
    ${current_date}    Get current date in format 'dd/MM/yyyy'
    Generate invoice number


    ${invoice_num}    Set Variable    ${TV_gen_invoice_num}
    ${invoice_date}    Set Variable    ${current_date}
    ${taxinvoice_date}     Set Variable    ${current_date}

    ${TV_invoice_num_upload}    Set Variable    ${TV_gen_invoice_num}

    Set Test Variable    ${invoice_num}
    Set Test Variable    ${invoice_date}
    Set Test Variable    ${taxinvoice_date}
    Set Test Variable    ${TV_invoice_num_upload}

    ${gr_line_num}    Get Length    ${source_dict['invoices']}

    #Loop for gr line item
    :FOR    ${index}    IN RANGE  ${gr_line_num}
        ${source_dict}    Replace Variables    ${source_dict}
        ${gr_list}    Get From List    ${source_dict['invoices']}    ${index}

        ${gr_list}    Replace Variables in YAML file    ${gr_list}
        ${gr_dict}    Convert To Dictionary    ${gr_list}
        ${gr_dict}    Evaluate    [${gr_dict}]

        Set To Dictionary    ${source_dict}    invoices    ${gr_dict}
    END

    [Return]    ${source_dict}  

