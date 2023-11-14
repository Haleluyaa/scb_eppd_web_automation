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
Get approval via invoice "${invoice_num}" and buyer,supplier "${buyer_supplier}" from api "${endpoint}"
    [Documentation]    Get approval data via invoice id and set to variable

    ${invoice_id}    Get invoice id for approval flow    ${buyer_supplier['supplier_mpid']}    ${invoice_num}

    ${response}    Run Keyword If    ${invoice_id}!=${None}    Get approval on approval work flow    ${endpoint['url']}    ${endpoint['uri']}    ${invoice_id}    ${buyer_supplier['buyer_mpid']}
    ...    ELSE    Set Variable    ${None}
    ${replace_data}    Run Keyword If    '${response}'!='${None}'    Parse data to variable    ${response}
    ...    ELSE    Set Variable    ${None}

    [Return]    ${replace_data}

Get approval via invoice "${invoice_num}" and buyer "${buyer}" and supplier "${supplier}" from api "${url}", "${uri}"
    [Documentation]    Get approval data via invoice id and set to variable

    ${invoice_id}    Get invoice id for approval flow    ${supplier}    ${invoice_num}

    ${response}    Run Keyword If    ${invoice_id}!=${None}    Get approval on approval work flow    ${url}    ${uri}    ${invoice_id}    ${buyer}
    ...    ELSE    Set Variable    ${None}
    ${replace_data}    Run Keyword If    '${response}'!='${None}'    Parse data to variable    ${response} 
    ...    ELSE    Set Variable    ${None}    

    [Return]    ${replace_data}  

Parse data to variable     
    [Arguments]    ${response}
    [Documentation]    Set approval data to variable as json

    ${json_object}    Parse Json    ${response.json()} 
    ${replace_data}    Get and set approval data to variable    ${json_object}

    [Return]    ${replace_data}

Rejected invoice "${invoice_num}" on buyer, supplier "${buyer_supplier}" from "${data_template}" to approval "${approval_endpoint}" and workflow "${workflow_endpoint}"
    [Documentation]    Reject invoice via post api, if no data; no doing

    ${replace_data}    Get approval via invoice "${invoice_num}" and buyer,supplier "${buyer_supplier}" from api "${approval_endpoint}"   
    Run Keyword If    ${replace_data}!=${None}    Post request insert/update data from template    ${data_template}    ${replace_data}    ${workflow_endpoint['url']}    ${workflow_endpoint['uri']}


Rejected invoice "${invoice_num}" on buyer "${buyer}" and supplier "${supplier}" from "${template_filename}" to endpoint "${api_endpoint}" and workflow "${workflow_uri}" approval "${approver_uri}"
    [Documentation]    Reject invoice via post api, if no data; no doing

    ${replace_data}    Get approval via invoice "${invoice_num}" and buyer "${buyer}" and supplier "${supplier}" from api "${api_endpoint}", "${approver_uri}"
    Run Keyword If    ${replace_data}!=${None}    Post request insert/update data from filename    ${template_filename}    ${replace_data}    ${api_endpoint}    ${workflow_uri}
  
Post request insert/update data from template
    [Arguments]    ${template}    ${replace_data}    ${endpoint}    ${uri}
    [Documentation]    Post request data from template and replace data

    ${dictionary_template}  Load yaml template to dictionary  ${template}
    ${dictionary_key}  Get key from dictionary  ${replace_data}
    ${request_data}    Update dictionary value to template from dict    ${dictionary_template}    ${dictionary_key}    ${replace_data}
    ${post_request_json}    Load dictionary to json format    ${request_data}
    ${response}    Post request data  ${workflow_endpoint['url']}    ${workflow_endpoint['uri']}    ${post_request_json}

Post request insert/update data from filename
    [Arguments]    ${template_filename}    ${replace_data}    ${endpoint}    ${uri}
    [Documentation]    Get template data from file name then get absolute path after that

    ${data_template}    Get work flow template file path    ${template_filename}

    ${dictionary_template}  Load yaml template to dictionary  ${data_template}
    ${dictionary_key}  Get key from dictionary  ${replace_data}
    ${request_data}    Update dictionary value to template from dict    ${dictionary_template}    ${dictionary_key}    ${replace_data}
    ${post_request_json}    Load dictionary to json format    ${request_data}
    ${response}    Post request data  ${endpoint}    ${uri}    ${post_request_json} 




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
Get work flow template file path
    [Arguments]    ${file_name}
    [Documentation]    Get relative path from argument file name

    ${target_file_path}     set variable    {CURDIT}/../mockdata_template/work-flow-controller/${file_name}
    ${file_path}    Get Canonical Path    ${target_file_path}

    [Return]    ${file_path}

Update dictionary value to template from dict
    [Arguments]    ${source_dict}    ${replace_dict_key}    ${replace_dict_val}
    [Documentation]    Update dictionary value over dictionary key

    ${new_request_data}    Update dictionary value  ${source_dict}    ${replace_dict_key}    ${replace_dict_val}

    [Return]    ${new_request_data}

Get and set approval data to variable
    [Arguments]    ${json_response}
    [Documentation]    Get and set data to robot dictionary

    Comment    Get approval data from json response then set to variable in correct Dictionary key
    ${approval_invoice_id}    Get and set approval invoice id    ${json_response}
    ${approval_approval_id}    Get and set approval approval id    ${json_response}
    @{approval_user}    Get and set approval approver user    ${json_response}
    ${approval_begindate}    Get and set approval approve begin date      ${json_response}
    ${approval_createdate}    Get and set approval approval create date    ${json_response}
    @{approval_dto_list}    Get and set invoiceApprovalDtoList    ${json_response}
    &{save_edit_attachment}    Get and set attachment save and edit data    ${approval_invoice_id}
    
    &{approval_replacing_parent}    Create Dictionary

    Set To Dictionary    ${approval_replacing_parent}    invoiceID    ${approval_invoice_id}
    Set To Dictionary    ${approval_replacing_parent}    approvalID    ${approval_approval_id}
    Set to Dictionary     ${approval_replacing_parent}    invoiceApprovalDtoList       ${approval_dto_list}
    Set to Dictionary     ${approval_replacing_parent}    attachmentSaveEdit       ${save_edit_attachment}

    [Return]    ${approval_replacing_parent}

Get and set attachment save and edit data
    [Arguments]    ${invoice_id}
    [Documentation]    Set data to dictionary, this keyword hardcode some value

    @{empty_list}=    Create List
    &{attachment_Save_Edit}    Create Dictionary
    Set To Dictionary    ${attachment_Save_Edit}    invoiceAttachments    ${empty_list}
    Set To Dictionary    ${attachment_Save_Edit}    invoiceID    ${invoice_id}
    Set To Dictionary    ${attachment_Save_Edit}    invoiceItemAttachments    ${empty_list}
    Set To Dictionary    ${attachment_Save_Edit}    updateBy    "Invoice_03"

    [Return]    &{attachment_Save_Edit}

Get and set invoiceApprovalDtoList
    [Arguments]    ${object}
    [Documentation]    Prepare some value of approval work flow api at key 'invoiceApprovalDtoList'

    ${invoice_approval_dto_list}    Set Variable    ${object['result']}

    [Return]    ${invoice_approval_dto_list}

Get and set approval invoice id    
    [Arguments]    ${object}
    [Documentation]    Set 'invoice id' to variable

    ${invoice_id}    Set Variable    ${object['result'][0]['invoiceID']}

    [Return]    ${invoice_id}

Get and set approval approval id     
    [Arguments]    ${object}
    [Documentation]    Set 'approval id' to variable

    ${approval_id}    Set Variable    ${object['result'][0]['approvalID']}

    [Return]    ${approval_id}

Get and set approval approver user
    [Arguments]    ${object}
    [Documentation]    Set 'approval user' to variable

    ${approver_user}    Set Variable    ${object['result'][0]['userDtoList']}  

    [Return]    ${approver_user} 

Get and set approval approve begin date
    [Arguments]    ${object}
    [Documentation]    Set 'approve begin date' to variable

    ${approve_begindate}    Set Variable    ${object['result'][0]['approveBeginDate']} 

    [Return]    ${approve_begindate}

Get and set approval approval create date
    [Arguments]    ${object}
    [Documentation]    Set 'approval create date' to variable

    ${approve_enddate}    Set Variable    ${object['result'][0]['approvalCreateDate']} 

    [Return]    ${approve_enddate}


Get invoice id for approval flow
    [Arguments]    ${supplier_mpid}    ${invoice_num}
    [Documentation]    Get invoice id from database

    @{response}    Get invoice id via supplier mpid and invoice number    ${supplier_mpid}    ${invoice_num}

    [Return]    ${response}[0][0]

Get approval on approval work flow
    [Arguments]    ${endpoint}    ${uri}    ${invoice_id}    ${buyermp_id}    ${index}=${None}
    [Documentation]    Get approval data via api, using parameter 

    ${params}    Set Variable    invoiceID=${invoice_id}&buyerMpID=${buyermp_id}
    ${response}    Get request data with param    ${endpoint}    ${uri}    ${params}

    [Return]    ${response}
