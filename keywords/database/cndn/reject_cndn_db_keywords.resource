
*** Keywords ***
Update current approve data to initial value
    [Documentation]    Update current approver to initial value, approve_status, updateby. update_date
    [Arguments]    ${credit_note_number}

    #Query
    #UPDATE CNDNApproval
    #SET CNDNApprovalID = 1
    #,UpdatedBy = 'Automatation'
    #,ApprovalNote = NULL
    #,ApproveEndDate = '4000-02-01'
    #,FROM CNDNApproval INNER JOIN CNDN
    #,ON CNDNApproval.CNDNID = CNDN.CNDNID
    #,WHERE CNDN.CNDNNum = 'CNDN_NUM' 
    #,AND CNDNApproval.SeqNum = 1   

Update "CNDN Number" data to initial value
    [Documentation]    Update the CNDN Number to the initial value
    [Arguments]    ${credit_note_number}

    #QUERY
    #UPDATE CNDN
    #SET StatusID = 1
    #,UpdatedBy = 'Automation'
    #WHERE CNDN.CNDNNum = 'CNDN_Number'

Delete next approver data from database
    [Documentation]    Delete next approve from database
    [Arguments]    ${credit_note_number}

    #Query
    #DELETE CNDNApproval
    #FROM CNDNApproval INNER JOIN CNDN
    #ON CNDNApproval.CNDNID = CNDN.CNDNID
    #WHERE CNDN.CNDNNum = 'CNDN_Number'
    #AND CNDNApproval.SeqNum = 2  

Verify insert credit/debit note history for credit/debit note
    [Documentation]    Verift insert credit/debit note history
    [Arguments]    ${cndn_number}    
    #Query