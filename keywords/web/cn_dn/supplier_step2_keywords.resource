*** Settings ***
Variables    ../../../resources/locators/cn_dn/step2_locator.yaml

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
Supplier delete invoice item row "${row_num}"
    ${invoice_num}    Get invoice number line item as list
    Delete invoice item at row    ${row_num}
    @{TV_deleted_invoice_num}    Set Variable    ${invoice_num}

    Set Test Variable    @{TV_deleted_invoice_num}
    
Invoice item should deleted and invoice item row 2 change to row 1
    Invoice item should be delete    ${TV_deleted_invoice_num}[0]
    Invoice line item at row 1 should be    ${TV_deleted_invoice_num}[1]
    
Back to created 'Credit/Debit Note' step1 when deleted all group credit/debit not in create 'Credit/Debit Note' step2
    Delete first credit/debit note group
    Create credit/debit note step1 should be shown
    Wait until loading complete

Supplier click 'Submit' button
    Click 'Submit' button

Error should be show at credit/debit note number and date
    Error required field should be shown for credit/debit note number
    Error required field should be shown for credit/debit note date
    

Error should be show at invoice 'Credit/Debut Note Date' and VAT when input only 'Creaid/Debit Note Tax' 
    Input 'Credit/Debit Note Tax'
    Click 'Submit' button
    Error required field should be shown for credit/debit note tax date
    Error required field should be shown for vat amount

Error should be shown at 'VAT Base Amount' when input input 'VAT' without 'VAT Base Amount'
    Input 'VAT'
    Clear data from 'VAT Base Amount'
    Click 'Submit' button
    Error required field should be shown for vat base amount

##### Adjust Item#####
Show adjust 'Credit/Debit Note' lines items when clicked on invoice item    
    Clicked first first 'Invoice' item
    Adjust items amount for 'Credit/Debit Note' should be shown

Error should be show at line item when input amount "${amount}" more than remaining invoice
    Input amount line items    ${amount}
    Error should be show lager than the remaining amount

Error should be show at line item when input amount "${EMPTY}" in text box    
    Input amount line items    ${EMPTY}
    Error line item should be show error

Error should be show at line item when input amount zero in text box    
    Input amount line items    0
    Modal error amount zero should be shown
    Close modal alert invoice amount is zero

Show data correctly in create credit/debit note step2 when input amount "${amount}" less than remaining    
    ${amt}    Input amount line items    ${amount}
    ${amount_precision}    Convert to number with precision    ${amt}    2
    Credit/Debit Note amount should be shown amount    ${amount_precision}
    Credit/Debit Note Amount Exclude VAT should be shown amount    ${amount_precision}
    Credit/Debit Note Amount Include VAT should be shown amount    ${amount_precision}
    Credit/Debit Note Amount total shown amount    ${amount_precision}

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
Credit/Debit Note amount should be shown amount
    [Arguments]    ${amount_precision}    ${row_num}=1
    [Documentation]    Verify Credit/Debit Note Amount same as expected 

    ${locator_credit_note_amount}    Replace Variables    ${sub_table_item_list['credit_note_amount']}

    Wait Until Element Is Visible       ${locator_credit_note_amount}    ${TIMEOUT}
    ${actual_amount}    Get Text    ${locator_credit_note_amount}

    Should Be Equal    ${actual_amount}    ${amount_precision}    message=Amount is equal

Credit/Debit Note Amount Exclude VAT should be shown amount
    [Arguments]    ${amount_precision}
    [Documentation]    Verify Credit/Debit Note Amount Exclude VAT same as expected

    ${actual_amount}    Get credit/debit note amount exclude vat

    Should Be Equal    ${actual_amount}    ${amount_precision}    message=Amount is equal

Get credit/debit note amount exclude vat
    [Arguments]    ${row_num}=1
    [Documentation]    Get value of Credit/Debit Note Amount Exclude VAT

    ${locator_credit_note_amount_ext_vat}    Replace Variables    ${table_cn_dn['credit_note_amount_ext_vat']}

    Wait Until Element Is Visible       ${locator_credit_note_amount_ext_vat}    ${TIMEOUT}
    ${actual_amount_extvat}    Get Text    ${locator_credit_note_amount_ext_vat}

    [Return]    ${actual_amount_extvat}

Credit/Debit Note Amount Include VAT should be shown amount
    [Arguments]    ${amount_precision}
    [Documentation]    Verify Credit/Debit Note Amount Include VAT same as expected
                ...    Calculate from 'VAT + CN/DN Amount'

    ${vat_amount}    Get 'VAT' Amount
    ${amount_exvat}    Get credit/debit note amount exclude vat
    ${amount_exvat}    Convert to number with precision    ${amount_exvat}    2

    ${amount_invat}    Get credit/debit note amount include vat 
    ${amount_invat}    Convert to number with precision    ${amount_invat}    2


    ${actual_amount}    Evaluate    ${amount_exvat}+${vat_amount}
    ${actual_amount}    Convert to number with precision    ${actual_amount}    2

    Should Be Equal    ${actual_amount}    ${amount_invat}    message=Amount is equal

Get 'VAT' Amount
    [Arguments]    ${row_num}=1
    [Documentation]    Get VAT

    ${locator_vat_amount}    Replace Variables    ${table_cn_dn['vat_amount']}

    Wait Until Element Is Visible      ${locator_vat_amount}    ${TIMEOUT}
    ${vat}    Get Value    ${locator_vat_amount}

    [Return]    ${vat}

Get credit/debit note amount include vat
    [Arguments]    ${row_num}=1
    [Documentation]    Get Credit/Debit Note Amount Include VAT

    ${locator_credit_note_amount_inc_vat}    Replace Variables    ${table_cn_dn['credit_not_amount_inc_vat']}

    Wait Until Element Is Visible        ${locator_credit_note_amount_inc_vat}    ${TIMEOUT}
    ${amount_invat}    Get Text     ${locator_credit_note_amount_inc_vat}

    [Return]    ${amount_invat}

Credit/Debit Note Amount total shown amount
    [Arguments]    ${amount_precision}
    [Documentation]   Verify Total Credit/Debit Note Amount same as expected
                ...   Calculate from sum(credit/debit note amount include vat) 

    Wait Until Element Is Visible       ${lbl_total_credit_debit_note_amount}    ${TIMEOUT}
    ${actual_amount}    Get Text    ${lbl_total_credit_debit_note_amount}

    ${amount_invat}    Get credit/debit note amount include vat 
    ${amount_invat}    Convert to number with precision    ${amount_invat}    2

    Should Be Equal    ${actual_amount}    ${amount_invat}    message=Amount is equal


Convert to number with precision
    [Arguments]    ${item}    ${precision}
    [Documentation]    Rounding item with precision

    ${amount}    Evaluate   '{:.2f}'.format(round(${item},${precision}))

    [Return]    ${amount}
 

Error should be show lager than the remaining amount
    [Arguments]    ${expected_err}=This amount cannot be larger than the remaining amount.
    [Documentation]    Verify error message when input 'Amount Line Item' more than 'Remaining Amount'

    Wait Until Element Is Visible    ${adjust_gr_item['lbl_error_first_row']}    ${TIMEOUT}
    ${err_msg}    Get Text    ${adjust_gr_item['lbl_error_first_row']}

    Should Contain    ${expected_err}    ${err_msg}

Error line item should be show error
    [Arguments]    ${expected_err}=This field is required.

    Wait Until Element Is Visible    ${adjust_gr_item['lbl_error_first_row']}    ${TIMEOUT}
    ${err_msg}    Get Text    ${adjust_gr_item['lbl_error_first_row']}

    Should Contain    ${expected_err}    ${err_msg}

Modal error amount zero should be shown
    [Arguments]    ${expected_err}=Invoice amount for all items are ZERO, please specify at least one item.

    Wait Until Element Is Visible    ${modal_error_adjust_gr_item['modal_zero_value_error']}    ${TIMEOUT}
    ${err_msg}    Get Text    ${modal_error_adjust_gr_item['modal_zero_value_error']}

    Should Contain    ${expected_err}    ${err_msg}


Close modal alert invoice amount is zero
    [Documentation]    Supplier clicked 'OK' button to close modal Alert

    Wait Until Element Is Visible     ${modal_error_adjust_gr_item['btn_ok']}    ${TIMEOUT}
    Click Button    ${modal_error_adjust_gr_item['btn_ok']}

Input amount line items
    [Arguments]    ${amount}

    ${amt}    Input amount line item     ${amount}
    Click 'Save' button

    [Return]    ${amt}

Click 'Save' button    
    [Documentation]    Save gr item line amount

     Wait Until Element Is Visible    ${adjust_gr_item['btn_save']}    ${TIMEOUT}
     Click Element    ${adjust_gr_item['btn_save']}

Input amount line item    
    [Arguments]    ${amount}
    [Documentation]    Supplier input amount line item to text box

    Wait Until Element Is Visible    ${adjust_gr_item['txt_gr_amount_all_row']}    ${TIMEOUT} 
    ${count}    Get Element Count    ${adjust_gr_item['txt_gr_amount_all_row']}

    ${invoice_amount}    Set Variable    0
    ${input_amount}    Set Variable    0

    FOR    ${index}    IN RANGE    1   ${count}+1

        ${row_num}    Set Variable    ${index}
        ${adjust_gr_amount_line_item_locator}    Replace Variables    ${adjust_gr_item['txt_gr_amount_line_item']}
        ${attr}    Get Element Attribute    ${adjust_gr_amount_line_item_locator}    disabled
        ${input_amount}    Run Keyword If    '${attr}'!='true'    Set item amount    ${adjust_gr_amount_line_item_locator}     ${amount}
        ...    ELSE    Set Variable    0
        ${invoice_amount}    Evaluate    ${invoice_amount}+${input_amount}
    END    
    [Return]    ${invoice_amount}

Set item amount
    [Arguments]    ${locator}    ${amount}
    [Documentation]    Input amount to item
                ...    Check condition Empty, More than remaining, Zero and correct remaining 

    Double Click Element    ${locator} 
    Click Element   ${locator}      DELETE 
    Input Text    ${locator}     ${amount} 
    log    ${amount}

    ${amount}    Run Keyword If    '${amount}'>='0'    Set Variable    ${amount} 
    ...    ELSE IF    '${amount}'=='${EMPTY}'    Set Variable    0
    ...    ELSE    Set Variable    0

    [Return]     ${amount}

Adjust items amount for 'Credit/Debit Note' should be shown
    [Documentation]    Modal adjust items for create 'Credit/Debit Note' should be show

    Wait Until Element Is Visible    ${adjust_gr_item['modal_content']}    ${TIMEOUT}
    Element Should Be Visible    ${adjust_gr_item['modal_content']}

Clicked first first 'Invoice' item
    [Arguments]    ${row_num}=1
    [Documentation]    Supplier clicked first invoice items at line number

    ${row_locator}    Replace Variables    ${sub_table_item_list['lbl_invoice_number']}

    Wait Until Element Is Visible    ${row_locator}    ${TIMEOUT}
    Click Element    ${row_locator}

Error required field should be shown for vat base amount
    [Arguments]    ${msg_expected}=This field is required    ${row_num}=1
    [Documentation]    Verify required field error for vat base amount

    ${lbl_error_vat_base_amount_locator}    Replace Variables    ${table_cn_dn['lbl_error_vat_base_amount']}

    Wait Until Element Is Visible    ${lbl_error_vat_base_amount_locator}    ${TIMEOUT}
    ${err_msg}    Get Text    ${lbl_error_vat_base_amount_locator}

    Should Contain    ${msg_expected}    ${err_msg}

Input 'VAT'
    [Arguments]    ${vat}=100    ${row_num}=1
    [Documentation]    Supplier input VAT Amount

    ${txt_vat_amount_locator}    Replace Variables    ${table_cn_dn['vat_amount']}

    Wait Until Element Is Visible    ${txt_vat_amount_locator}    ${TIMEOUT} 
    Double Click Element    ${txt_vat_amount_locator}
    Click Element    ${txt_vat_amount_locator}    DELETE
    Input Text    ${txt_vat_amount_locator}    ${vat}

Clear data from 'VAT Base Amount'
    [Arguments]    ${group_no}=1
    [Documentation]    Supplier clear value at text box VAT Base Amount
 
    ${txt_vat_base_amount_locator}    Replace Variables    ${table_cn_dn['txt_vat_base_amount']}
    
    Wait Until Element Is Visible    ${txt_vat_base_amount_locator}    ${TIMEOUT}
    Clear Element Text    ${txt_vat_base_amount_locator}

Error required field should be shown for vat amount
    [Arguments]    ${msg_expected}=This field is required    ${row_num}=1
    [Documentation]    Verify error should be shown at vat amount

    ${lbl_error_vat_amount_locator}    Replace Variables    ${table_cn_dn['lbl_error_vat_amount']}

    Wait Until Element Is Visible    ${lbl_error_vat_amount_locator}    ${TIMEOUT}
    Element Should Be Visible     ${lbl_error_vat_amount_locator}

    ${err_msg}    Get Text    ${lbl_error_vat_amount_locator}
    Should Contain    ${msg_expected}    ${err_msg}        

Input 'Credit/Debit Note Tax'
    [Arguments]    ${input_text}=TXN    ${group_no}=1
    [Documentation]    Supplier input credit/debit note tax number  
    ${txt_tax_number_locator}    Replace Variables    ${table_cn_dn['txt_tax_invoice_number']}

    Wait Until Element Is Visible    ${txt_tax_number_locator}
    Input Text    ${txt_tax_number_locator}    ${input_text}

Error required field should be shown for credit/debit note tax date
    [Arguments]    ${msg_expected}=This field is required    ${row_num}=1
    [Documentation]    Verify required field error for credit/debit note number

    ${lbl_error_tax_date_locator}    Replace Variables    ${table_cn_dn['lbl_error_tax_date']}
    #debug
    Wait Until Element Is Visible    ${lbl_error_tax_date_locator}    ${TIMEOUT} 
    ${err_msg}    Get Text    ${lbl_error_tax_date_locator}

    Should Contain    ${msg_expected}    ${err_msg}

Error required field should be shown for credit/debit note number
    [Arguments]    ${msg_expected}=This field is required    ${row_num}=1
    [Documentation]    Verify required field error for credit/debit note number

    ${lbl_error_credit_note_num_locator}    Replace Variables    ${table_cn_dn['lbl_error_credit_note_number']}   

    Wait Until Element Is Visible    ${lbl_error_credit_note_num_locator}    ${TIMEOUT}
    ${err_msg}    Get Text    ${lbl_error_credit_note_num_locator}

    Should Contain    ${msg_expected}    ${err_msg}
    

Error required field should be shown for credit/debit note date
    [Arguments]    ${msg_expected}=This field is required    ${row_num}=1
    [Documentation]    Verify required field error for credit/debit note date

    ${lbl_error_credit_note_date_locator}    Replace Variables    ${table_cn_dn['lbl_error_credit_note_date']}

    Wait Until Element Is Visible    ${lbl_error_credit_note_date_locator}    ${TIMEOUT}
    ${err_msg}    Get Text    ${lbl_error_credit_note_date_locator}

    Should Contain    ${msg_expected}    ${err_msg}
    

Click 'Submit' button
    [Documentation]    Click submit credit/debit note button

    Wait Until Element Is Visible    ${btn_submit}    ${TIMEOUT}
    Click Button    ${btn_submit} 

Delete first credit/debit note group
    Select check box from first credit/debit note group
    Click delete button to delete credit/debit note group
    Confirm delete credit/debit note group

Select check box from first credit/debit note group
    [Arguments]    ${group_no}=1
    [Documentation]    Checked at check box at credit/debit note group
    
    ${chk_select_credit_note_locator}    Replace Variables    ${table_cn_dn['chk_select_group_credit_note']}

    Wait Until Element Is Visible    ${chk_select_credit_note_locator}    ${TIMEOUT}
    Select Checkbox    ${chk_select_credit_note_locator}    

Click delete button to delete credit/debit note group
    [Documentation]    Click Delete button to delete Credit/Debit Note Group
                ...    Delete button be visible after checked to check box

    Wait Until Element Is Visible    ${btn_delete_group_credit_note} 
    Click Button    ${btn_delete_group_credit_note}          

Invoice item should be delete
    [Arguments]    ${invoice_number}
    [Documentation]    Invoice number not show in create credit/debit note step 2
    #debug
    Page Should Not Contain    '${invoice_number}'

Invoice line item at row 1 should be
    [Arguments]    ${invoice_num}    ${row_num}=1    ${group_no}=1
    [Documentation]    Verify invoice number in first line
 
    ${lbl_invoice_num_locator}    Replace Variables    ${sub_table_item_list['lbl_invoice_num_line_group']}
    ${actual_invoice_num}    Get Text     ${lbl_invoice_num_locator}

    Should Be Equal As Strings    ${actual_invoice_num}    ${invoice_num}


Get invoice number line item as list
    [Arguments]    ${row_num}=1    ${group_no}=1
    [Documentation]    Get invoice number from line items in create credit/debit note step2

    ${lbl_invoice_num_locator}    Replace Variables    ${sub_table_item_list['lbl_invoice_num_all_line_group']}

    @{list_invoice_num}    Create List
    ${count}    Get Element Count    ${lbl_invoice_num_locator}
    FOR    ${index}    IN RANGE    ${count}
        ${row_locator}    Replace Variables    ${sub_table_item_list['lbl_invoice_num_index_line_group']}
        ${invoice_num}    Get Text    ${row_locator} 
        Append To List    ${list_invoice_num}    ${invoice_num}
    END

    [Return]    @{list_invoice_num}
   

Delete invoice item at row 
    [Arguments]    ${row_num}
    [Documentation]    Delete invoice number
    Click delete item on invoice    ${row_num}
    Confirm delete invoice line item

Click delete item on invoice
    [Arguments]   ${row_num}=1    ${group_no}=1
    [Documentation]    Click icon delete to delete invoice line item

    ${lbl_invoice_num_locator}    Replace Variables    ${sub_table_item_list['lbl_invoice_num_line_group']}
    ${ico_delete_invoice_line_num_locator}    Replace Variables    ${sub_table_item_list['ico_delete_invoice_line_num']}

    Wait Until Element Is Visible    ${ico_delete_invoice_line_num_locator}    ${TIMEOUT}
    ${invoice_num}    Get Text    ${lbl_invoice_num_locator}
    Click Element    ${ico_delete_invoice_line_num_locator}

    [Return]    ${invoice_num}

Confirm delete invoice line item
    [Documentation]    Click confirm delete invoice line item on modal delete

    Wait until loading complete
    Wait Until Element Is Visible    ${btn_confirm_delete_invoice_line_item}    ${TIMEOUT}
    Click Element    ${btn_confirm_delete_invoice_line_item}

Confirm delete credit/debit note group
    [Documentation]    Click 'Confirm' button to delete Credit/Debit Note group

    Wait Until Element Is Visible    ${btn_confirm_delete_group_credit_note}    ${TIMEOUT}
    Click Button    ${btn_confirm_delete_group_credit_note}
 

Required field message for invoice number should be ${expected_message}
    [Documentation]    verify message combine compare condition with 'or' and 'or' should be lower case
    Wait Until Element Is Visible    ${lbl_invoice_number_cndn_err_msg_locator}
    ${actual_message}=    GET TEXT    ${lbl_invoice_number_cndn_err_msg_locator}
    Should Be True    '${actual_message}'=='${expected_message.en}' or '${actual_message}'=='${expected_message.th}'

Required field message for invoice date should be ${expected_message}  
    [Documentation]    verify message combine compare condition with 'or' and 'or' should be lower case
    Wait Until Element Is Visible    ${lbl_invoice_cndn_date_err_msg_locator}
    ${actual_message}=    GET TEXT    ${lbl_invoice_cndn_date_err_msg_locator}
    Should Be True    '${actual_message}'=='${expected_message.en}' or '${actual_message}'=='${expected_message.th}'

Message error invoice number should be visible
    Wait Until Element Is Visible    ${lbl_invoice_number_cndn_err_msg_locator}
    Element Should Be Visible    ${lbl_invoice_number_cndn_err_msg_locator}

Message error invoice date should be visible
    Wait Until Element Is Visible    ${lbl_invoice_cndn_date_err_msg_locator}
    Element Should Be Visible    ${lbl_invoice_cndn_date_err_msg_locator}

Message error invoice number should not be visible   
    Wait Until Element Is Not Visible     ${lbl_invoice_number_cndn_err_msg_locator}
    Element Should Not Be Visible    ${lbl_invoice_number_cndn_err_msg_locator}

Message error invoice date should not be visible
    Wait Until Element Is Not Visible    ${lbl_invoice_cndn_date_err_msg_locator}
    Element Is Not Be Visible     ${lbl_invoice_cndn_date_err_msg_locator}     

Input invoice number on invoice row ${row_number} with ${prefix}
    ${txt_invoice_number_cndn_locator}=    Replaceing the locator of ${txt_invoice_number_cndn_locator} from SEQ_REPLACE_ME to integer ${row_number}
    Wait Until Element Is Visible    ${txt_invoice_number_cndn_locator}
    #Click Element    ${txt_invoice_number_cndn_locator} 

    #Wait Until Element Is Visible    ${txt_invoice_number_cndn_locator}
    ${current_date}    Get current date by format %Y%m%d_%H%M%S%f and adjust 0
    Input Text    ${txt_invoice_number_cndn_locator}      ${prefix}${current_date}

Press tab on text box invoice number on invoice row ${row_number}
    ${txt_invoice_number_cndn_locator}=    Replaceing the locator of ${txt_invoice_number_cndn_locator} from SEQ_REPLACE_ME to integer ${row_number}
    Wait Until Element Is Visible    ${txt_invoice_number_cndn_locator}
    Press tab key ${txt_invoice_number_cndn_locator}

Click on text box invoice number on invoice row ${row_number}
    ${txt_invoice_number_cndn_locator}=    Replaceing the locator of ${txt_invoice_number_cndn_locator} from SEQ_REPLACE_ME to integer ${row_number}
    Wait Until Element Is Visible    ${txt_invoice_number_cndn_locator}
    Press tab key ${txt_invoice_number_cndn_locator}    

Click on text box invoice date on invoice row ${row_number}
    ${txt_invoice_date_cndn_locator}=    Replaceing the locator of ${txt_invoice_date_cndn_locator} from SEQ_REPLACE_ME to integer ${row_number}
    Wait Until Element Is Visible    ${txt_invoice_date_cndn_locator}
    Click Element    ${txt_invoice_date_cndn_locator}

Choose invoice date on current date on invoice row ${row_number}
    ${current_year}    ${current_month}    ${current_day}    Get current date system 

    #${txt_invoice_date_cndn_locator}=    Replace ${txt_invoice_date_cndn_locator} from SEQ_REPLACE_ME to ${row_number}
   # ${txt_cld_invoice_date_locator}=    Replaceing the locator of ${txt_cld_invoice_date_locator} from SEQ_REPLACE_ME to integer ${row_number}
    #Wait until element is visible    ${txt_cld_invoice_date_locator}
    #Click Element    ${txt_cld_invoice_date_locator}
    #Click Element    //*[@id="rb_txt_calendar_invoice_1"]
    Click on text box invoice date on invoice row ${row_number}
    Sleep    2
    Wait Until Element Is Visible    ${step2_calendar_popup_locator}
    Select Calendar on ${step2_calendar_popup_locator} for ${current_year} and ${current_month} and ${current_day}

############## For Tax Invoice Number, Tax Invoice Date ###############
Required field message for tax invoice number should be ${expected_message}
    Wait Until Element Is Visible    
    ${actual_text}    Get Text
    Should Be True    '${actual_message}'=='${expected_message.en}' OR '${actual_message}'=='${expected_message.th}'

Required field message for tax invoice date should be ${expected_message}   
   Wait Until Element Is Visible
   ${actual_text}    Get Text    
   Should Be True   '${actual_message}'=='${expected_message.en}' OR '${actual_message}'=='${expected_message.th}' 
 
Message error tax invoice number should be visible
    Wait Until Element Is Visible
    Element Should Be Visible

Message error tax invoice date should be visible
    Wait Until Element Is Visible
    Element Should Be Visible

Message error tax invoice number should not be visible   
    Wait Until Element Is Not Visible
    Element Should Not Be Visible

Message error tax invoice date should not be visible
    Wait Until Element Is Not Visible
    Element Should Not Be Visible

Press tab on text box tax invoice number on invoice row ${row_number}
    ${txt_tax_invoice_number_cndn_locator}=    Replaceing the locator of ${txt_tax_invoice_number_cndn_locator} from SEQ_REPLACE_ME to integer ${row_number}
    Wait Until Element Is Visible    ${txt_tax_invoice_number_cndn_locator}
    Press tab key ${txt_tax_invoice_number_cndn_locator}    

Input credit/debit note tax invoice number   
    Wait until element is visible    
    ${current_date}    Get current date by format 'YYYY-MM-DD hh:mm:ss.mil' and adjust '0'
    Input Text    

Choose credit/debit note tax invoice date on current date
    ${current_year}    ${current_month}    ${current_day}    Get current date system 

    ${txt_invoice_date_cndn_locator}=    Replace ${txt_invoice_date_cndn_locator} from 'SEQ_REPLACE_ME' to '1'
    Wait until element is visible   
    Click Element
    Wait Until Element Is Visible    ${step2_calendar_popup_locator}
    Select Calendar on ${step2_calendar_popup_locator} for ${current_year} and ${current_month} and ${current_date}   














