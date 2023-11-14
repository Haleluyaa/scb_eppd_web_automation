*** Settings ***
Variables    ../../../resources/locators/cn_dn/edit_cndn_locators.yaml

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
User upload document successfully
    User click attachment icon document cndn level
    Upload file to 'Credit / Debit Note' section   
    Verify upload file to 'Credit / Debit Note' section successful
    Click done button 
    ## User click attachment icon document invoice level row '1'
    ## Upload file to 'GR Slip' section
    ## Verify upload file to 'GR Slip' section successful

Click "Done" button on attachment modal
    Click done button 

Choose upload files on credit/debit note level on this file "${files}"
    Click on choose file button of      ${cndn_level_attach.btn_choose_file_contract}
    Select file to upload as attachment     ${files}    ${cndn_level_attach.browse_contract}
    #Press    ESC

Choose upload files on invoice level on this file "${files}"
    Click on choose file button of      ${invoice_level_attach.btn_choose_file_contract}
    Select file to upload as attachment for invoice level     ${files}    ${invoice_level_attach.browse_contract}
    #Press    ESC    #closed dialog upload

User click attachment icon document cndn level
    Click attachment icon cndn level

User click attachment icon document invoice level row '${row_num}'
    Click attachment icon invoice level at row  ${row_num}

Upload file to 'Credit / Debit Note' section
    Click on choose file button of      ${cndn_level_attach.btn_choose_file_contract}
    Select file to upload as attachment     ${ATTACHMENT_FILE.RESUBMIT}    ${cndn_level_attach.browse_contract}

Verify upload file to 'Credit / Debit Note' section successful
    verify file name show correctly at row     1   ${ATTACHMENT_FILE.RESUBMIT}    ${cndn_level_attach.lbl_file_name_contract_with_row} 
    verify delete file button show up at row    1   ${cndn_level_attach.btn_file_delete_contract_with_row}
    user can input note for this attachment at row    1     ${cndn_level_attach.txt_note_contract_with_row}

User click resubmit cndn
    Click resubmit button
    Click on 'Yes button' to resubmit cndn

# User is able to upload successfully
#     Verify attached file in DB
    

Set CNDN "${cndn_num}" to status Pending 
    Update value to field 'CN/DN status' in DB       ${STATUS.PENDING}    '${cndn_num}'

Delete CNDN attachment CNDNNumber "${cndn_num}"
    Delete row 'CN/DN attachment' in DB     '${cndn_num}'

Input note for this attachment "${note}" into text box on credit/debit note level 
    [Documentation]    Input message to attachment

    Input note for this attachment into text box at first position   ${note}

Input note for this attachment "${note}" into text box on invoice level  
    [Documentation]    Input message to attachment   

    Input note for this attachment into text box at first position on invoice level     ${note}

Select check box send file to supplier on credit/debit note level
    [Documentation]    Checked on check box

    Checked at checkbox send file to supplier

Select check box send file to supplier on invoice level
    [Documentation]    Checked on check box

    Checked at checkbox send file to supplier

CNDNNumber "${cndnnumber_attach}" data for attachment on credit/debit note level should be correctly with "${note}"  
    [Documentation]    Verify the data in database

    Verify data for edit attachment at credit/debit note level in db    ${cndnnumber_attach}    ${note}

CNDNNumber "${cndnnumber_attach}" data for attachment on invoice level should be correctly with "${note}"  
    [Documentation]    Verify the data in database

    Verify data for edit attachment at invoice level in db      ${cndnnumber_attach}    ${note}               

Click attachment icon on invoice level
    [Documentation]    Click the attachment icon at invoice level
    Click icon attahcment at invoice level (item level) at first row

Error message at credit/debit note level when incorrect format file should be "${error_message}"
    [Documentation]    Verify the error message when incorrect file format
    Error format file at credit/debit note level should be    ${error_message}

Error message at invoice level when incorrect format file should be "${error_message}"
    [Documentation]    Verify the error message when incorrect file format
    Error format file at invoice level should be    ${error_message}

Error message at credit/debit note level when maximum file size should be "${error_message}"
    [Documentation]    Verify the error message on credit/debit note level when file size over limit (5 MB)
    Error maximum file size at credit/debit note level should be  ${error_message}

Error message at invoice level when maximum file size should be "${error_message}"
    [Documentation]    Verify the error message on invoice level when file size over limit (5 MB)
    Error maximum file size at invoice level should be  ${error_message}

Modal edit attachment after completed on credit/debit note level should be correctly with label "${message}" and place holder is "${place_holder}"
    [Documentation]    Verify the attachment when completed upload file on credit/debit note level
    Check box send to supplier on credit/debit note level should be display and label should be    ${message} 
    Text box "Note To Supplier" on credit/debit note level should be display and place holder should be     ${place_holder}
    Click "Done" button on attachment modal

Modal edit attachment after completed on invoice level should be correctly with label ${message} and place holder is ${place_holder}
    [Documentation]    Verify the attachment when completed upload file on invoice level
    Check box send to supplier on invoice level should be display and label should be    ${message}   
    Text box "Note To Supplier" on invoice level should be display and place holder should be    ${place_holder}
    Click "Done" button on attachment modal

Verify icon attachment when upload completed on credit/debit note level
    [Documentation]    Verify the system show icon attachment with upload completed icon
    Icon completed on credit note/debit note level should be correctly displayed

Verify icon attachment when upload completed on invoice level  
    [Documentation]    Verify the system show icon attachment with upload completed icon     
    Icon completed on invoice level should be correctly displayed  

Closed upload attachment file credit/debit note modal  
    [Documentation]    Closed attachment modal

    Closed upload modal

Verify success download file on credit/debit note level
    [Documentation]    Verify success download file

    Download files success    

Verify success download file on invoice level
    [Documentation]    Verify success download file

    Download files success 

Fill required data duedate '${due_date}' and payment location '${location}'
    Select due date      ${due_date}
    Select payment location     ${location}

Click "Approve" button on edit credit/debit note
    [Documentation]    Click approve button
    Click approve button
    Click 'Confirm' on confirm approve cn/dn modal 

Click download file at credit/debit note level at first position
    [Documentation]    Download file   

    Click download file at first position

Click download file at invoice level at first position
    [Documentation]    Download file   

    Click download file at first position                       
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
Click attachment icon cndn level
    Wait Until Element Is Visible      ${cndn_level_attach.btn_cndn_attach}      ${TIMEOUT}
    Click Element    ${cndn_level_attach.btn_cndn_attach}

Click done button
    Wait Until Element Is Visible   ${cndn_level_attach.btn_done}  
    Click Element   ${cndn_level_attach.btn_done}  

Click on choose file button of
    [Arguments]  ${xpath}
    Wait Until Page Contains Element    ${xpath}
    Wait Until Element Is Visible    ${xpath}
    Click Element    ${xpath}

Select file to upload as attachment
    [Arguments]    ${file_name}     ${xpath_section}
    ${target_file_path}     set variable    ${CURDIR}../../../../resources/testdata/${env}/attachment/${file_name}
    ${file_path}    Get Canonical Path    ${target_file_path}
    Choose File    ${cndn_level_attach.browse_contract}    ${file_path}
    Sleep   5s

Select file to upload as attachment for invoice level
    [Arguments]    ${file_name}     ${xpath_section}
    ${target_file_path}     set variable    ${CURDIR}../../../../resources/testdata/${env}/attachment/${file_name}
    ${file_path}    Get Canonical Path    ${target_file_path}
    Choose File    ${invoice_level_attach.browse_contract}    ${file_path}
    Sleep   5s    

verify file name show correctly at row     
    [Arguments]     ${filerow}     ${file_name}    ${attach_section_path}
    ${target_obj}   Replace variables   ${attach_section_path}
    Element text should be      ${target_obj}        ${file_name}

verify delete file button show up at row  
    [Arguments]     ${filerow}      ${attach_section_path}
    ${target_obj}   Replace variables   ${attach_section_path}
    Wait Until Element Is Visible      ${target_obj}        

user can input note for this attachment at row     
    [Arguments]     ${filerow}      ${attach_section_path}
    ${target_obj}   Replace variables   ${attach_section_path}
    Wait Until Element Is Enabled    ${target_obj}    ${TIMEOUT}

click resubmit button
    Wait Until Element Is Visible    ${footer_section.btn_resubmit}
    Click Element    ${footer_section.btn_resubmit}            

Click on 'Yes button' to resubmit cndn
    Wait Until Element Is Visible    ${footer_section.btn_footer_submit_yes}
    Click Element    ${footer_section.btn_footer_submit_yes}

Select due date   
    [Arguments]    ${due_date}
    #Convert Date Format
    ${due_date}=    Convert Date    ${due_date}    result_format=%Y-%m-%d
    #Get month and year
    ${month_txt}=    Convert Date    ${due_date}    result_format=%B
    ${year_txt}=    Convert Date    ${due_date}    result_format=%Y

    ${string_due_date_wo_zeropad}       Convert To String   ${due_date}    
    ${string_due_date_wo_zeropad}=     Replace string      ${string_due_date_wo_zeropad}      -0      -


    Click Element       ${due_date_calendar.btn_calendar}

    #Select Month
    :FOR    ${i}    IN RANGE    999999
    \    ${month_checker}=    Run Keyword And Return Status    Element Should Contain   ${due_date_calendar.spn_from_month_select}    ${month_txt}
    \    Exit For Loop If    ${month_checker} == True
    \    Wait Until Element Is Visible         ${due_date_calendar.btn_previous_from_month}    ${TIMEOUT}
    \    Click element     ${due_date_calendar.btn_previous_from_month}
    #Select Year
    :FOR    ${i}    IN RANGE    999999
    \    ${year_checker}=    Run Keyword And Return Status    Element Should Contain   ${due_date_calendar.spn_from_year_select}    ${year_txt}
    \    Exit For Loop If    ${year_checker} == True
    \    Wait Until Element Is Visible         ${due_date_calendar.btn_previous_from_year}    ${TIMEOUT}
    \    Click element     ${due_date_calendar.btn_previous_from_year}
    #Select Date
    Execute Javascript    document.querySelector("td[title='${string_due_date_wo_zeropad}'] > div").click()    

Select payment location    
    [Arguments]    ${location}
    Select From List By Label   ${ddl_payment_location}    ${location}

Closed upload modal
    [Documentation]    Closed attachment modal by click X Cross button

    Click Element    ${cndn_level_attach.btn_close}

Click icon attachment at credit/debit note level at first row  
    [Documentation]    Click attachment icon at first row in credit/debit note level

    Wait Until Element Is Visible    ${cndn_level_attach.btn_cndn_attach}    ${TIMEOUT}
    Click Element    ${cndn_level_attach.btn_cndn_attach}

Click icon attahcment at invoice level (item level) at first row
    [Documentation]    Click attachment icon at first row in invoice level

    Wait Until Element Is Visible    ${invoice_level_attach.btn_inv_attach_firstrow}    ${TIMEOUT}
    Click Element    ${invoice_level_attach.btn_inv_attach_firstrow}

Error format file at credit/debit note level should be
    [Documentation]    Verify error message on credit/debit note level when format file invalid
                ...    This keyword allow only one bow row error
    [Arguments]    ${expect_message}

    Wait Until Element Is Visible   ${cndn_level_attach.lbl_error}  ${TIMEOUT}
    ${actual_message}    Get Text    ${cndn_level_attach.lbl_error_msg}
    Should Contain Any  ${expect_message}    ${actual_message}

Error format file at invoice level should be
    [Documentation]    Verify error message on invoice level when format file invalid
                ...    This keyword allow only one bow row error
    [Arguments]    ${expect_message}   

    Wait Until Element Is Visible   ${invoice_level_attach.lbl_error}   ${TIMEOUT}
    ${actual_message}    Get Text   ${invoice_level_attach.lbl_error_msg}
    Should Contain Any      ${expect_message}    ${actual_message} 

Error maximum file size at credit/debit note level should be
    [Documentation]    Verify error message on credit/debit note level when file size over limit
                ...    This keyword allow only one bow row error
    [Arguments]    ${expect_message}    

    Wait Until Element Is Visible   ${cndn_level_attach.lbl_error}  ${TIMEOUT}
    ${actual_message}    Get Text    ${cndn_level_attach.lbl_error_msg}
    Should Contain Any  ${expect_message}    ${actual_message}     

Error maximum file size at invoice level should be
    [Documentation]    Verify error message on invoice level when file size over limit
                ...    This keyword allow only one bow row error
    [Arguments]    ${expect_message}   

    Wait Until Element Is Visible   ${invoice_level_attach.lbl_error}   ${TIMEOUT}
    ${actual_message}    Get Text   ${invoice_level_attach.lbl_error_msg}
    Should Contain Any      ${expect_message}    ${actual_message}

Check box send to supplier on credit/debit note level should be display and label should be    
    [Documentation]    Verify check box send to supplier should be display and correct label
                ...    when upload file completed
                ...    This keyword accept only only one success file
    [Arguments]    ${expected_message}

    Wait Until Element Is Visible    ${cndn_level_attach.cbk_sent_to_supplier}    ${TIMEOUT}
    ${actual_message}    Get Text    ${cndn_level_attach.lbl_sent_to_supplier}
    Element Should Be Visible    ${cndn_level_attach.cbk_sent_to_supplier}
    Should Contain Any    ${expected_message}    ${actual_message} 

Check box send to supplier on invoice level should be display and label should be    
    [Documentation]    Verify check box send to supplier should be display and correct label
                ...    when upload file completed
                ...    This keyword accept only only one success file
    [Arguments]    ${expected_message}

    Wait Until Element Is Visible    ${invoice_level_attach.cbk_sent_to_supplier}    ${TIMEOUT}
    ${actual_message}    Get Text    ${invoice_level_attach.lbl_sent_to_supplier}
    Element Should Be Visible    ${invoice_level_attach.cbk_sent_to_supplier}
    Should Contain Any    ${expected_message}    ${actual_message}     

Text box "Note To Supplier" on credit/debit note level should be display and place holder should be 
    [Documentation]    Verify text box "Note To Supplier" should be display and correct place holder
    [Arguments]    ${expected_message}

    Wait Until Element Is Visible    ${cndn_level_attach.txt_note_to_supplier}
    ${actual_message}    Get Element Attribute From Locator  ${cndn_level_attach.txt_note_to_supplier}  placeholder
    Element Should Be Visible    ${cndn_level_attach.txt_note_to_supplier}
    Should Contain Any    ${expected_message}    ${actual_message}  

Text box "Note To Supplier" on invoice level should be display and place holder should be 
    [Documentation]    Verify text box "Note To Supplier" should be display and correct place holder
    [Arguments]    ${expected_message}   

    Wait Until Element Is Visible    ${invoice_level_attach.txt_note_to_supplier}
    ${actual_message}    Get Element Attribute From Locator     ${invoice_level_attach.txt_note_to_supplier}    placeholder
    Element Should Be Visible    ${invoice_level_attach.txt_note_to_supplier}
    Should Contain Any    ${expected_message}    ${actual_message}     

Icon completed on credit note/debit note level should be correctly displayed
    [Documentation]    Verify icon upload completed on credit/debit note level

    Wait Until Element Is Visible    ${cndn_level_attach.icn_attachment_noti_green}    ${TIMEOUT} 
    Element Should Be Visible    ${cndn_level_attach.icn_attachment_noti_green}   

Icon completed on invoice level should be correctly displayed    
    [Documentation]    Verify icon upload completed on invoice level

    Wait Until Element Is Visible    ${invoice_level_attach.icn_attachment_noti_green}
    Element Should Be Visible    ${invoice_level_attach.icn_attachment_noti_green}

Wait until uploading success
    [Documentation]    Wait until upload file success when uploading bar not display

    Wait Until Element Is Not Visible    ${cndn_level_attach.lbl_loadbar}


Click download file at first position
    [Documentation]    Download file

    Wait Until Element Is Visible   ${cndn_level_attach.btn_download}
    Click Element   ${cndn_level_attach.btn_download}

Download files success   
    [Documentation]    Verify download attachment file success    


Input note for this attachment into text box at first position    
    [Documentation]    Input note into textbox
    [Arguments]    ${note}

    Wait Until Element Is Visible    ${cndn_level_attach.txt_note_to_supplier}
    Input Text    ${cndn_level_attach.txt_note_to_supplier}    ${note}   

Input note for this attachment into text box at first position on invoice level   
    [Documentation]    Input note into textbox
    [Arguments]    ${note}

    Wait Until Element Is Visible    ${invoice_level_attach.txt_note_to_supplier}
    Input Text    ${invoice_level_attach.txt_note_to_supplier}    ${note}        

Checked at checkbox send file to supplier   
    [Documentation]    Selected Checkbox

    Wait Until Element Is Visible    ${cndn_level_attach.cbk_sent_to_supplier}    ${TIMEOUT}
    Select Checkbox    ${cndn_level_attach.cbk_sent_to_supplier}   

Verify data for edit attachment at credit/debit note level in db
    [Documentation]    Verify data in database
    [Arguments]    ${cndnnumber_attach}     ${note}
    ${cndn_id}=    eInvoice Execute SELECT query string     SELECT CNDNID FROM CNDN WHERE CNDNNum = '${cndnnumber_attach}'
    ${cndn_id}=    Set Variable   ${cndn_id}[0][0]
    ${cndn_attachment}=     eInvoice Execute SELECT query string    SELECT top 1 Purpose,SendToSupplier,AttachmentName FROM CNDNAttachment WHERE CNDNID = ${cndn_id} ORDER BY CreatedDate DESC
    ${Purpose}=    Set Variable   ${cndn_attachment}[0][0]
    ${SendToSupplier}=    Set Variable   ${cndn_attachment}[0][1]
    ${AttachmentName}=    Set Variable   ${cndn_attachment}[0][2]
    Should be Equal     ${note}    ${Purpose}

Verify data for edit attachment at invoice level in db
    [Documentation]    Verify data in database
    [Arguments]    ${cndnnumber_attach}     ${note}
    ${cndn_id}=    eInvoice Execute SELECT query string     SELECT CNDNID FROM CNDN WHERE CNDNNum = '${cndnnumber_attach}'
    ${cndn_id}=    Set Variable   ${cndn_id}[0][0]
    ${cndnitem_id}=    eInvoice Execute SELECT query string     SELECT CNDNItemID FROM CNDNItem WHERE CNDNID = ${cndn_id} order by linenum asc
    ${cndnitem_id}=    Set Variable   ${cndnitem_id}[0][0]
    ${cndn_attachment}=     eInvoice Execute SELECT query string    SELECT top 1 Purpose,SendToSupplier,AttachmentName FROM CNDNItemAttachment WHERE CNDNItemID = ${cndnitem_id} ORDER BY CreatedDate DESC
    ${Purpose}=    Set Variable   ${cndn_attachment}[0][0]
    ${SendToSupplier}=    Set Variable   ${cndn_attachment}[0][1]
    ${AttachmentName}=    Set Variable   ${cndn_attachment}[0][2]
    Should be Equal     ${note}    ${Purpose}

Click approve button
    Wait Until Element Is Visible    ${btn_approve}
    Click element       ${btn_approve}

Click 'Confirm' on confirm approve cn/dn modal 
    Wait Until Element Is Visible    ${btn_confirm_approve}
    Click element       ${btn_confirm_approve}
