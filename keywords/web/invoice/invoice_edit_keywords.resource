*** Settings ***
Variables    ../../../resources/locators/invoice/invoice_edit_locators.yaml

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
Click submit button in edit invoice
    Click submit button

Error noti should be show on invoice attachment
    [Documentation]    Show noti error attachment invoice at row 1    
    Noti error should be show at attachment invoice row 1

Error noti should be show on po attachment 
    [Documentation]    Show noti error attachment po at row 1 of invoice 1    
    Noti error should be shown at attachment po row 1 on invoice 1







Error noti should be disappear when attached required files "${files_inv}" to "${invoice_type_loc}" and files "${files_po}" to "${po_type_loc}"
    Add attachment files to invoice    ${files_inv}    ${invoice_type_loc}
    Add attachment files to po    ${files_po}    ${po_type_loc}
    Noti icon error not show attachment invoice level
    Noti icon error not show attachment po level 
Attach file "${file}" to invoice level at type "${attachment_type}"
    Wait until loading complete
    Add attachment files to invoice    ${file}    ${attachment_type}

Attach file "${file}" to po level at type "${attachment_type}"
    Wait until loading complete
    Add attachment files to po    ${file}    ${attachment_type}

Noti attach file invoice level show be show 
    Show noti attachment file invoice for first invoice
Noti attach file po level should be show    
    Show noti attachment file po for first po in first invoice

Click cancel submit draft invoice   
    Click button 'Cancel' submit draft invoice 

Click confirm submit draft invoice    
    Click button 'Submit' confirm submit draft invoice
    
Edit invoice detail should be show  
    Page 'Edit Invoice' page is shown  

Popup amount exceed gr line amount shown with message "${expected_message}"
    ${actual_error}    Get warning from popup warning
    Should be equal as string comparision and expected    ${actual_error}    ${expected_message}

Edit invoice page again when click OK button on popup warning 
    Click 'OK' button on popup warning amount exceed   
    Page 'Edit Invoice' page is shown

Close edit invoice page    
    Click 'X' to close edit invoice page
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
Click 'X' to close edit invoice page
    Wait Until Element Is Visible    ${ico_close_edit_page}    ${TIMEOUT}
    Click Element    ${ico_close_edit_page}

Get warning from popup warning
    [Documentation]

    Wait Until Element Is Visible    ${popup_submit_warning['msg_exceed_gr_amount']}    ${TIMEOUT}
    ${err_msg}    Get Text    ${popup_submit_warning['msg_exceed_gr_amount']}

    [Return]    ${err_msg}

Click 'OK' button on popup warning amount exceed
    [Documentation]    Click 'OK' button on warnning popup amount exceeds from submit draft invoice

    Wait Until Element Is Visible    ${popup_submit_warning['btn_ok']}    ${TIMEOUT}
    Click Button    ${popup_submit_warning['btn_ok']}

Page 'Edit Invoice' page is shown
    Element Should Be Visible    ${btn_submit}    message=Submit button set to active

Click submit button
    Wait Until Element Is Visible    ${btn_submit}    ${TIMEOUT}
    Click Button    ${btn_submit}

Click button 'Cancel' submit draft invoice    
    Wait Until Element Is Visible    ${submit_obj['btn_cancel']}    ${TIMEOUT}
    Click Button    ${submit_obj['btn_cancel']}

Click button 'Submit' confirm submit draft invoice    
    Wait Until Element Is Visible    ${submit_obj['btn_confirm_submit']}    ${TIMEOUT}
    Click Element    ${submit_obj['btn_confirm_submit']}

Noti error should be show at attachment invoice row 1
    Wait Until Element Is Visible    ${invoice_attachment['noti_error_row1']}    ${TIMEOUT}
    Element Should Be Visible    ${invoice_attachment['noti_error_row1']}    message=Notification icon is shown on invoice attachment icon at row 1 

Noti error should be shown at attachment po row 1 on invoice 1
    Wait Until Element Is Visible    ${po_attachment['noti_error_row1_inv_1']}    ${TIMEOUT}
    Element Should Be Visible    ${po_attachment['noti_error_row1_inv_1']}    message=Notification icon is shown on po attachment icon of invoic row 1 

Add attachment files to invoice
    [Arguments]    ${files}    ${locator}

    Click icon attachment on invoice level at first invoice
    Add attachment to invoice level   ${files}    ${locator}
    Click button 'Done' on attach invoice level

Click icon attachment on invoice level at first invoice    
    [Documentation]

    Wait Until Element Is Visible    ${invoice_attachment['icon_attachment_row1']}    ${TIMEOUT}
    Click Element    ${invoice_attachment['icon_attachment_row1']}

Add attachment files to po    
    [Arguments]    ${files}    ${locator}

    Click icon attachment on first po level at first invoice
    Add attachment to po level   ${files}    ${locator}
    Click button 'Done' on attach po level 

Add attachment to invoice level
    [Arguments]    ${files}    ${attachment_type}
    
    ${path_file}    Get Canonical Path    ${files}
    ${path_file}    Replace Variables    ${path_file}
    ${btn_browse_file}    Replace Variables    ${attach_to_invoice['btn_browse_fils_specified']}
    ${attachment_locator}    Replace Variables    ${attach_to_invoice['input-type_specified']}

    Click browse file button    ${btn_browse_file}
    Choose File    ${attachment_locator}   ${path_file}
    
    Wait Until Page Contains Element    ${attach_to_invoice['txt_note_to_attachment_contains']}    ${TIMEOUT}
    Closig popup browse files     

Add attachment to po level
    [Arguments]    ${files}    ${attachment_type}

    ${path_file}    Get Canonical Path    ${files}
    ${path_file}    Replace Variables    ${path_file}
    ${btn_browse_file}    Replace Variables    ${attach_to_po['btn_browse_fils_specified']}
    ${attachment_locator}    Replace Variables    ${attach_to_po['input-type_specified']}

    Click browse file button    ${btn_browse_file}
    Choose File    ${attachment_locator}    ${path_file}  

    Wait Until Page Contains Element    ${attach_to_po['txt_note_to_attachment_contains']}    ${TIMEOUT}
    Closig popup browse files  

Click browse file button
    [Arguments]    ${locator}

    Wait Until Element Is Visible    ${locator}
    Click Element    ${locator}      

Click icon attachment on first po level at first invoice
    [Documentation]

    Wait Until Element Is Visible    ${po_attachment['icon_attachment_row1_inv1']}    ${TIMEOUT}
    Click Element    ${po_attachment['icon_attachment_row1_inv1']}    

Click button 'Done' on attach invoice level
    Wait Until Element is visible    ${attach_to_invoice['btn_done']}    ${TIMEOUT}
    Click Button    ${attach_to_invoice['btn_done']}

Click button 'Done' on attach po level    
    Wait Until Element Is Visible    ${attach_to_po['btn_done']}    ${TIMEOUT}
    Click Element    ${attach_to_po['btn_done']}

Noti icon error not show attachment invoice level
    Element Should Not Be Visible    ${invoice_attachment['noti_error_row1']}

Noti icon error not show attachment po level   
    Element Should Not Be Visible    ${po_attachment['noti_error_row1_inv_1']}  

Closig popup browse files
    [Arguments]    ${keyboard_key}=ESC
    [Documentation]    Library keyboard
                ...    Closed dialogs browse files via press ESC

    Press    ${keyboard_key}   

Show noti attachment file invoice for first invoice
    Page Should Contain Element    ${invoice_attachment['noti_attach_row1']}    message=Attached file successfully for invoice

Show noti attachment file po for first po in first invoice
    Page Should Contain Element     ${po_attachment['noti_attach_row1_inv_1']}    message=Attached file successfully for po

