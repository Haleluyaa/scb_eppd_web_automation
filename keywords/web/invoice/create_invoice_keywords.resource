*** Settings ***
Variables    ../../../resources/locators/invoice/create_invoice_locator.yaml

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
User create Invoice with buyer "${buyer_name}"
    Click "Create Invoice" button
    Click "Select PR/PO" button
    Click "Please select buyer..." dropdown list
    Input value to "Buyer Search" text field    ${buyer_name}
    Click on first row of PO to see invoice details
    Click "Next" button to "Create Invoice"

Select all PO and Create New Invoice
    Select all PO by check dropdown list on table
    Click "Create New Invoice" button
    Click "Next" button to summary PO of Invoice

Select PO GR at first row and Create new invoice
    Select PO GR at first row
    Click "Create New Invoice" button
    Click "Next" button to summary PO of Invoice

Go to Invoice details page
    Click first row of PO to drew down to "Invoice Details"

"${column_name}" column first row in create invoice page should equal to "${total_amount}"
    ${actual_retention_firstrow}=  Get cell text by column name and row number    ${column_name}    1
    Should Be Equal As Numbers    ${total_amount}    ${actual_retention_firstrow}

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
Select all PO by check dropdown list on table
    Wait Until Element Is Visible    ${obj_create_invoice.add_invoice_step.chb_select_all_po}    ${TIMEOUT}
    Click Element    ${obj_create_invoice.add_invoice_step.chb_select_all_po}

Select PO GR at first row
    

Click "Create New Invoice" button
    Wait Until Element Is Visible    ${obj_create_invoice.add_invoice_step.btn_create_new_invoice}    ${TIMEOUT}
    Click Element    ${obj_create_invoice.add_invoice_step.btn_create_new_invoice}

Click "Next" button to summary PO of Invoice
    Wait Until Element Is Enabled    ${obj_create_invoice.add_invoice_step.btn_next}    ${TIMEOUT}
    Click Element    ${obj_create_invoice.add_invoice_step.btn_next}

Click first row of PO to drew down to "Invoice Details"
    Wait until loading complete
    Wait Until Element Is Enabled    ${obj_create_invoice.invoice_detail_step.lbl_invoice_details_first_row_second_col}    ${TIMEOUT}
    Click Element    ${obj_create_invoice.invoice_detail_step.lbl_invoice_details_first_row_second_col}

Get column number by column name
    [Arguments]    ${column_name}
    ${column_number}=  Set Variable    0
    @{items}=  Get WebElements    ${obj_create_invoice.invoice_detail_step.lbl_cols_po_list}
    FOR    ${item}    IN    @{items}   
       ${column_number}=    Evaluate    ${column_number} + 1
       ${actual_col_name}=   Get Text   ${item}
       Run Keyword If    '${actual_col_name.upper()}' == '${column_name.upper()}'    Exit For Loop  
    END     
    ${column_number}=    Evaluate    ${column_number} - 1
    [Return]   ${column_number}

Get cell text by column name and row number
    [Arguments]    ${column_name}    ${row_number}
    ${col_number}=  Get column number by column name    ${column_name}
    ${obj_target_cell}=  Replace Variables    ${obj_create_invoice.invoice_detail_step.lbl_cell_in_table}
    ${cell_text}=   Get Text   ${obj_target_cell}
    [Return]   ${cell_text}    
