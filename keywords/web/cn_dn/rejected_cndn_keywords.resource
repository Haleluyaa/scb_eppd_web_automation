*** Settings ***
Variables    ../../../resources/locators/cn_dn/rejected_cndn_locator.yaml

*** Keywords ***
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

Prepare Credit/Debit Note for rejected test cases
    [Documentation]    Create Credit/Debit Note via API


Set Credit/Debit Not for rejected test cases to initial value on CNDN Number is "${credit_note_number}"
    [Documentation]    Set Credit/Debit Note to initial value

    Update Credit/Debit Note of first approve to initial data    ${credit_note_number}
    Delete next approver data from database
    Update "CNDN Number" data to initial value    ${credit_note_number}

The system must display the pop up reject debit/credit note
    [Documentation]    Verify the "Reject Modal" that show on screen

    Show "Modal Reject" on the screen

The pop up reject debit/credit note Title must be "${title_text}" 
    [Documentation]    Verify the "Reject Modal" title, value should be list variable for support multi language

    "Modal Reject" title must be    ${title_text} 

The pop up reject debit/credit note Text area Place holder is "${place_holder_text}" and Title is "${title_text}" and length is "${length}"
    [Documentation]    Verify the "Reject Modal" text area place holder, title and mex length; value should be list variable for support multi language 

    "Modal Reject" Text area Title must be    ${title_text}
    "Modal Reject" Text area Place Holder and length must be    ${place_holder_text}   ${length}

The pop up reject debit/credit note must show "Confirm" button with label "${text_label_confirm}" and "Cancel" button with label "${text_label_cancel}"  
    [Documentation]    Verify the "Reject Modal" button and button's label

    "Modal Reject" must be display correct button    ${text_label_confirm}    ${text_label_cancel}

Error on the "Modal Rejected" must be correctly with message "${error_message}"
    [Documentation]    Verify the error message and style on Modal Reject Credit / Debit Note    

    Error required rejected reason on Modal Reject Credit/DEbit Note must be    ${error_message}


Click "Confirm Button" to reject credit/debit note
    [Documentation]    Click "Confirm Button" that display on the Modal Reject Credit /Debit Note

    Click confirm button on Modal Reject Credit/Debit Note

Click "Cancel Button" to cancel reject credit/debit note    
    [Documentation]    Click "Reject Button" that display on the modal Reject Credit /Debit Note 

    Click reject button on Modal Reject Credit/Debit Note 

"Modal Reject Credit/Debit Note" must hide from the screen     
    [Documentation]    Verify the system not show "Modal Reject Credit/Debit Note" on the screen"

    "Modal Reject" must hide from the screen

The system must be inserted/update the Reject Data correctly on cndn number is "${CNDN_NUMBER}"
    [Documentation]    Verify the system insert and update reject data in database correctly
                ...    Both current approver and next approver

    Approve data credit/debit note must be correct    ${CNDN_NUMBER}
    Invoice status data credit/debit note must be correct    ${CNDN_NUMBER}

Input reject credit/debit note to maximum value with reason "${reject_area}"   
    [Documentation]    Input reject credit/debit note reason to text area

    Input reject reason to text area    ${reject_area}                                 

The system must correct insert Credit/Debit Note history for "${cndn_number}"
    [Documentation]    Verify insert credit/debit note history correctly

    Verify insert credit/debit note history for credit/debit note    ${cndn_number}    


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

Click confirm button on Modal Reject Credit/Debit Note
    [Documentation]    Click "Confirm Button" that display on the Modal Reject Credit /Debit Note
    Wait Until Element Is Visible    ${btn_confirm_rejected}    ${TIMEOUT}
    Click Element    ${btn_confirm_rejected}  

Click reject button on Modal Reject Credit/Debit Note 
    [Documentation]    Click "Reject Button" that display on the modal Reject Credit /Debit Note  
    Wait Until Element Is Visible    ${btn_cancel_rejected}    ${TIMEOUT}
    Click Element    ${btn_cancel_rejected}        

Error required rejected reason on Modal Reject Credit/Debit Note must be
    [Arguments]    ${expect_message}
    [Documentation]    Verify the error message on "Modal Reject Credit/Debit Note"

    ${actual_messsage}    Get Text    ${txt_form_rejected_required_error}
    Should Contain Any    ${expect_message}    ${actual_messsage}
    Element Should Be Visible    ${ico_required_error}
    Element Should Be Visible    ${frm_required_error}       

Show "Modal Reject" on the screen
    [Documentation]    Verify the "Reject Modal" must be display on the screen
    Element Should Be Visible    ${mdl_rejected_cndn}    

"Modal Reject" title must be   
    [Arguments]    ${expected_title}
    [Documentation]    Verify the title of "Reject Modal".
                ...    An arguments is title text

    Wait Until Element Is Visible    ${lbl_modal_rejected_cndn_title}   ${TIMEOUT}
    ${actual_title}    Get Text    ${lbl_modal_rejected_cndn_title}
    Should Contain Any    ${expected_title}    ${actual_title}    

"Modal Reject" Text area Title must be
    [Arguments]    ${expect_title}
    [Documentation]    Verify the title of "Reject Modal" text area.
                ...    An arguments is text area title text

    Wait Until Element Is Visible    ${lbl_reason_rejected_cndn_title}    ${TIMEOUT}   
    ${actual_title}    Get Text    ${lbl_reason_rejected_cndn_title} 
    Should Contain Any    ${expect_title}    ${actual_title}        

"Modal Reject" Text area Place Holder and length must be 
    [Arguments]    ${expect_placeholder}    ${expect_length}
    [Documentation]    Verify the "Reject Modal" text area place holder and acceapable maximum max length.
                ...    An arguments is "Place Holder Text" and Maximum Length

    Wait Until Element Is Visible    ${txt_reason_rejected_cndn}    ${TIMEOUT}
    ${actual_placeholder}    Get Element Attribute From Locator    ${txt_reason_rejected_cndn}    placeholder
    ${max_length}    Get Element Attribute From Locator    ${txt_reason_rejected_cndn}    maxlength   

    Should Contain Any    ${expect_placeholder}    ${actual_placeholder}  
    Should Be Equal As Strings    ${max_length}    ${expect_length}  

"Modal Reject" must be display correct button
    [Arguments]    ${expect_confirm_label}    ${expect_cancel_label}
    [Documentation]    Verify display's button on "Reject Modal" and lable on the button.
                ...    The arguments are confirm button label and cancel button label

    # Verify display's button
    Element Should Be Visible    ${btn_confirm_rejected}
    Element Should Be Visible    ${btn_cancel_rejected}   

    # Verify button's label
    ${actual_confirm_label}    Get Text    ${btn_confirm_rejected}
    ${actual_cancel_label}    Get Text    ${btn_cancel_rejected}
    Should Contain Any    ${expect_confirm_label}    ${actual_confirm_label}
    Should Contain Any    ${expect_cancel_label}    ${actual_cancel_label}     

"Modal Reject" must hide from the screen
    [Documentation]    Verify the Modal Reject Credit/Debit Note must be hide from the screen
                ...    When click Cancel Button on Modal Reject Credit/Debit Note

    Element Should Not Be Visible    ${mdl_rejected_cndn_content}     

Update Credit/Debit Note of first approve to initial data
    [Arguments]    ${credit_note_number}
    [Documentation]    

    Update current approve data to initial value    ${credit_note_number}     

Input reject reason to text area
    [Documentation]    Input reject rason to reject text area at "Modal Reject Credit/DEbit Note"
    [Arguments]    ${reject_area}      
 
    Wait Until Element Is Visible    ${txt_reason_rejected_cndn}    ${TIMEOUT}
    Input Text    ${txt_reason_rejected_cndn}    ${reject_area}

Approve data credit/debit note must be correct    
    [Documentation]    Verify cndn number approve status
    [Arguments]    ${cndn_number_status} 

Invoice status data credit/debit note must be correct
    [Documentation]    Verify cndn number status         
