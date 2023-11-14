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

Verify correctly update approval data on "${cndn_document_number}" same as ${expected_data}

    ${cndn_approve_data}=    Get approved data from db     ${cndn_document_number}
    Verify credit/debit note approver for verify    ${cndn_approve_data}    ${expected_data}

Approve staus cndn "${cndn_document_number}" update to "${approve_status}"
    ${cndn_approve_data}=    Get approved data from db     ${cndn_document_number}
    Approve status should be    ${cndn_approve_data}[0][3]    ${approve_status}

Approve approver name for cndn "${cndn_document_number}" should be "${buyer_name}"
    ${cndn_approve_data}=    Get approved data from db     ${cndn_document_number}
    Approver name should be    ${cndn_approve_data}[0][4]    ${buyer_name}

Approve note for cndn "${cndn_document_number}" should be "${note}"
    ${cndn_approve_data}=    Get approved data from db     ${cndn_document_number}
    Approve note should be    ${cndn_approve_data}[0][5]    ${note}

Verify correctly insert history logs should be had "${row_count}" rows
    ${db_row_count}=    History log for approve credit/debit note on current approver
    Verify number of cndn approved history log should be equal expected    ${db_row_count}    ${row_count}

Verify correctly update credit/debit note same as "${expected_data}"
   
    ${actual_cndn_data}=    Get cndn data from db    ${cndn_id_for_approved}    ${buyer_mpid}
    Verify update credit/debit note after approved by verify user    ${actual_cndn_data}    ${expected_data}





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
Approve note should be    
    [Arguments]    ${actual}    ${expected}
    [Documentation]    Verify approved note

    Should be equal as string comparision and expected    ${actual}    ${expected}

Approve status should be
    [Arguments]    ${actual}    ${expected}
    [Documentation]    Verify approve status id as expected

    Should be equal as string comparision and expected    ${actual}    ${expected} 
  
Approver name should be    
    [Arguments]    ${actual}    ${expected}
    [Documentation]    Verify approver name

    Should be equal as string comparision and expected    ${actual}    ${expected} 

Get approved data from db
    [Arguments]    ${cndn_number}

    Get cndnid from db      ${cndn_number}
    ${cndn_approve_data}    Get approval data from db     ${cndn_id_for_approved}

    [Return]    ${cndn_approve_data}

Verify credit/debit note approver for verify
    [Arguments]    ${approved_data}    ${expected_data}
    [Documentation]    Verification of approved data same as expected    


    Run Keyword If    "${expected_data.VERIFY.APPROVER_TYPE}"=="Verify Document"
    ...    Verify credit/debit note on verify document for verify    ${approved_data}[${0}]    ${expected_data}

    Run Keyword If    "${expected_data.ACCOUNT_PAYABLE.APPROVER_TYPE}"=="Account Payable"
    ...    Verify credit/debit note on account payable for verify    ${approved_data}[${1}]    ${expected_data}


Verify credit/debit note on verify document for verify
    [Arguments]    ${actual_approved_data}    ${expected_data}
    [Documentation]    Verify approved data on approver type is verify document
                ...    Approver is Verify Document Level
                ...    ${buyer_username} from test variable

    Approved sequence number should be as expected    "${actual_approved_data}[0]"    "${expected_data.VERIFY.SEQ}"
    Approved approval type should be as expected    "${actual_approved_data}[1]"    "${expected_data.VERIFY.APPROVER_TYPE}"
    Approved templated sequence should be as expected    "${actual_approved_data}[2]"    "${expected_data.VERIFY.APPROVALTEMPLATE_SEQ}"   
    Approved approval status should be as expected    "${actual_approved_data}[3]"    "${expected_data.VERIFY.APPROVAL_STATUS}"   
    Approved approver should be as expected    "${actual_approved_data}[4]"    "${buyer_username}"    
    Approved approval note should be as expected      "${actual_approved_data}[5]"    "${expected_data.VERIFY.APPROVAL_NOTE}"    
    Approved update by should be as expected    "${actual_approved_data}[6]"     "${buyer_username}"
    ${expected_comparision_date}=    Get comparison date from now to then
    Verify comparision date should be less than actual date    ${actual_approved_data}[7]     ${expected_comparision_date}   

Verify credit/debit note on account payable for verify
    [Arguments]    ${actual_approved_data}    ${expected_data}
    [Documentation]    Verify approved data on approver type is verify document
                ...    Approver is Account Payable Level
                ...    ${buyer_username} from test variable
       
    Approved sequence number should be as expected    "${actual_approved_data}[0]"    "${expected_data.ACCOUNT_PAYABLE.SEQ}"
    Approved approval type should be as expected    "${actual_approved_data}[1]"    "${expected_data.ACCOUNT_PAYABLE.APPROVER_TYPE}"
    Approved templated sequence should be as expected    "${actual_approved_data}[2]"    "${expected_data.ACCOUNT_PAYABLE.APPROVALTEMPLATE_SEQ}"   
    Approved approval status should be as expected    "${actual_approved_data}[3]"    "${expected_data.ACCOUNT_PAYABLE.APPROVAL_STATUS}"   
    Approved approver should be as expected    "${actual_approved_data}[4]"     "${expected_data.ACCOUNT_PAYABLE.APPROVER}"
    Approved approval note should be as expected      "${actual_approved_data}[5]"    "${expected_data.ACCOUNT_PAYABLE.APPROVAL_NOTE}"      
    Approved update by should be as expected   "${actual_approved_data}[6]"     "${buyer_username}"
    ${expected_comparision_date}=    Get comparison date from now to then
    Verify comparision date should be less than actual date    ${actual_approved_data}[7]     ${expected_comparision_date}   

Approved sequence number should be as expected   
    [Arguments]    ${actual_sequence_num}    ${expect}
    [Documentation]     Actual Sequence Number should be same as expected data    

    Should Be Equal As Strings     ${actual_sequence_num}    ${expect}    msg=Actual sequence number equal as expected

Approved approval type should be as expected   
    [Arguments]    ${actual_approval_type}    ${expect}
    [Documentation]     Approved Approval Type should be same as expected data   

    Should Be Equal As Strings     ${actual_approval_type}    ${expect}    msg=Actual approval type equal as expected

Approved templated sequence should be as expected   
    [Arguments]    ${actual_templete_seq}    ${expect}
    [Documentation]     Actual Template Sequence should be same as expected data    

    Should Be Equal As Strings     ${actual_templete_seq}    ${expect}    msg=Actual approval templated sequence equal as expected

Approved approval status should be as expected   
    [Arguments]    ${actual_approval_status}    ${expect}
    [Documentation]     Actual Approval Status should be same as expected data  

    Should Be Equal As Strings     ${actual_approval_status}    ${expect}    msg=Actual approval status equal as expected   

Approved approver should be as expected   
    [Arguments]    ${actual_approver}    ${expect}
    [Documentation]     Actual Approver should be same as expected data  

    Should Be Equal As Strings     ${actual_approver}    ${expect}    msg=Actual approver equal as expected   

Approved approval note should be as expected   
    [Arguments]    ${actual_approval_note}    ${expect}
    [Documentation]     Actual Approval Note should be same as expected data 

    Should Be Equal As Strings     ${actual_approval_note}    ${expect}    msg=Actual approval note equal as expected   

Approved update by should be as expected   
    [Arguments]    ${actual_update_by}    ${expect}
    [Documentation]     Actual Update By should be same as expected data  

    Should Be Equal As Strings     ${actual_update_by}    ${expect}    msg=Actual update by equal as expected  

Verify comparision date should be less than actual date
    [Arguments]    ${actual_update_date}    ${expect}
    [Documentation]     Actual Update Date should be same as expected data  

    Should Be True     "${actual_update_date}">"${expect}"    msg=Update date around the estimmated date                              

Get comparison date from now to then
    [Documentation]    Get current date minus 10 minutes

    ${current_date}=    Get Current Date    	time_zone=local
    ${estimate_comparison_date}=    Add Time To Date    ${current_date}    -10 minute

    [Return]    ${estimate_comparison_date}

History log for approve credit/debit note on current approver
    [Documentation]

    ${query_string}=    Get row count history log approved cndn    ${cndn_id_for_approved}    ${buyer_username}
    ${row_count}=    eInvoice Execute Row Count query string    ${query_string}

    [Return]    ${row_count}

Verify number of cndn approved history log should be equal expected
    [Arguments]    ${actual_row_count}    ${expected_row_count}  

    Should Be True    ${actual_row_count}==${expected_row_count}    msg=History row count should be equal as expected

Get cndnid from db 
    [Arguments]    ${cndn_number}
    [Documentation]    Get cndn_id from database required cndn_number 
                ...    Others data get from Test Variable

    ${query_string}=    Get cndnid for approve cndn    ${cndn_number}     
    ${cndn_id}=    eInvoice Execute SELECT query string    ${query_string}       

    ${cndn_id_for_approved}=    Set Variable    ${cndn_id}[0][0]

    Set Test Variable    ${cndn_id_for_approved}

Get approval data from db 
    [Arguments]    ${cndn_approved_id}
    [Documentation]    Get approval data from database

    ${query_string}    Get cndn approval data    ${cndn_approved_id}
    ${approval_data}    eInvoice Execute SELECT query string    ${query_string}

    [Return]    ${approval_data}


Get cndn data from db
    [Arguments]    ${cndn_id}    ${mpid}
    [Documentation]    Get credit or debit not data via condition cndn id and buyer mpid

    ${query_string}    Get cndn data via cndn id and buyermp id    ${cndn_id}    ${mpid}
    ${cndn_data}    eInvoice Execute SELECT query string    ${query_string}    

    [Return]   ${cndn_data} 

Verify update credit/debit note after approved by verify user
    [Arguments]    ${cndn_data}    ${expected_data}

    Verify update credit/debit note status    ${cndn_data}[0][0]    ${expected_data}
    Verify update credit/debit note update by    ${cndn_data}[0][1]    ${buyer_username}

    ${comparison_date}=    Get comparison date from now to then
    Verify comparision date should be less than actual date    ${cndn_data}[0][2]    ${comparison_date} 

Verify update credit/debit note status   
    [Arguments]    ${cndn_data}    ${expected}

    Should Be Equal As Strings    ${cndn_data}    ${expected}    msg=CNDN Status equal expected status

Verify update credit/debit note update by 
    [Arguments]    ${cndn_data}    ${expected}

    Should Be Equal As Strings    ${cndn_data}    ${expected}    msg=CNDN update by equal expected status
