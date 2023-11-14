*** Settings ***
Variables    ../../../resources/locators/invoice/invoice_details_locator.yaml

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
Select all retention unit to Amount and input all amount by "${amount}"
    Select "Amount" unit to all enable row
    ${total_amount}=  Input value "Amount" to all enable row    ${amount}
    Set Test Variable    ${total_amount}   ${total_amount}
    Click "Save" button to save invoice Details

Select retention unit to % and Amount and input all amount by "${amount}"
    ${total_amount}=  Select "%" and "Amount" unit as swap and input value to all enable row    ${amount}    
    Set Test Variable    ${total_amount}   ${total_amount}
    Click "Save" button to save invoice Details

Select retention unit to Amount and input amount over invoice amount for first row
    ${actual_error_message}=  Get error message when select "Amount" unit and input over invoice amount by provide row    1    
    Set Test Variable    ${actual_error_message}   ${actual_error_message}

Error message display under field "${expect_error_message}"
    Message error should be as expected    ${expect_error_message}    ${actual_error_message}

When click on 'Save' still on page with error "${expect_error_message}"
    Click "Save" button to save invoice Details
    Message error should be as expected    ${expect_error_message}    ${actual_error_message}

Click on the first PO of PO Detail    
    Click on the first row of PO Detail in view invoice page

Click on the first PO of PO Detail for Non GR
    Click on the first row non gr of PO Detail in view invoice page

User click button history
    Click "History" button   

User click button edit
    Click 'Edit' button
    Wait until loading complete

Prepare validate PO Number and GR Number from row "${row_num}"
    Get PO Number at first row    ${row_num}
    Get GR Number at first row    ${row_num}

Click on PO Number at the row "${row_num}"
   Click on PO Number at row in detail page    ${row_num}       

User click button delete in invoice detail
    Wait until loading complete
    Wait Until Element Is Visible       ${obj_invoice_details.action.btn_delete}     ${TIMEOUT}
    Click Element   ${obj_invoice_details.action.btn_delete}

User confirm deleted draft invoice
    Confirm delete modal display
    Click yes submit on confirm delete modal 
    
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
Click on PO Number at row in detail page
    [Arguments]    ${row_num}

    ${target_cel}    Replace Variables    ${tbl_nested_inv1['row_selected']}

    Wait Until Element Is Visible    ${target_cel}
    Click Element    ${target_cel}

Get PO Number at first row
    [Arguments]    ${row_num}

    ${target_cel}    Replace Variables    ${tbl_nested_inv1['col_po_no']}

    ${TV_PONumber_ViewGR}    Get Text    ${target_cel} 
    Set Test Variable        ${TV_PONumber_ViewGR} 

Get GR Number at first row
    [Arguments]    ${row_num}

    ${target_cel}    Replace Variables    ${tbl_nested_inv1['col_gr_no']}

    ${TV_GRNumber_ViewGR}    Get Text    ${target_cel} 
    Set Test Variable        ${TV_GRNumber_ViewGR}  


##    -------


Click on the first row of PO Detail in view invoice page
    Wait Until Element Is Visible    ${obj_view_invoice_detail.tbl_po_detail.row_first}
    Click Element    ${obj_view_invoice_detail.tbl_po_detail.row_first}

Click on the first row non gr of PO Detail in view invoice page
    Wait Until Element Is Visible    ${obj_view_invoice_detail.tbl_po_detail.row_first_nongr}
    Click Element    ${obj_view_invoice_detail.tbl_po_detail.row_first_nongr}   


Select "Amount" unit to all enable row
    @{items}=  Get WebElements    ${obj_invoice_details.ddl_retention_unit}
    : FOR    ${item}    IN    @{items}    
    \    sleep  1s
    \    Click Element   ${item}
    \    Wait Until Element Is Visible    ${obj_invoice_details.lbl_Amount_in_list}    3s
    \    Click Element    ${obj_invoice_details.lbl_Amount_in_list}

Input value "Amount" to all enable row
    [Arguments]    ${value}
    ${total_amount}=  Set Variable    0
    @{items}=  Get WebElements    ${obj_invoice_details.ddl_retention_input}
    : FOR    ${item}    IN    @{items}   
    \   Clear Element Text    ${item}
    \   Input Text   ${item}    ${value}
    \   ${total_amount}=    Evaluate    ${total_amount} + ${value}    
    [Return]   ${total_amount}

Click "Save" button to save invoice Details
    Wait Until Element Is Enabled    ${obj_invoice_details.btn_save}    ${TIMEOUT}
    Click Element    ${obj_invoice_details.btn_save}

Select "%" and "Amount" unit as swap and input value to all enable row
    [Arguments]   ${value}
    ${total_amount}=  Set Variable    0    
    @{items_unit}=  Get WebElements    ${obj_invoice_details.ddl_retention_unit}
    @{items_input}=  Get WebElements    ${obj_invoice_details.ddl_retention_input}

    ${count}=  get length   ${items_unit}
    : FOR    ${i}    IN RANGE    0    ${count}
    \    sleep  1s
    \    Click Element   ${items_unit[${i}]}
    \    ${num_mod}=    Evaluate    (${i}+1)%2
    \    Run Keyword If   '${num_mod}' == '1'    Click "Amount" unit
                                 ...    ELSE     Click "%" unit    
    \    ${total_amount}=  Run Keyword If   '${num_mod}' == '1'    Input and Calculate "Amount" unit value    ${items_input[${i}]}    ${total_amount}    ${value}
                                                   ...    ELSE     Input and Calculate "%" unit value    ${items_input[${i}]}    ${total_amount}    ${value}

    ${total_amount}=    Evaluate    round(${total_amount}, 2)    
    [Return]  ${total_amount}

Input and Calculate "%" unit value
    [Arguments]   ${obj_target_input}    ${total_value}    ${percent_value}
    Clear value then Input value to target field    ${obj_target_input}    ${percent_value}
    ${item_amount}=  Get Invoice amount in 'Invoice Details page' by provide retention amount related object    ${obj_target_input}
    ${total_value}=    Evaluate    ${total_value} + round(((${item_amount}*${percent_value})/100),2)
    [Return]   ${total_value}  

Input and Calculate "Amount" unit value
    [Arguments]   ${obj_target_input}    ${total_value}    ${added_value}
    Clear value then Input value to target field    ${obj_target_input}    ${added_value}
    ${total_value}=    Evaluate    ${total_value} + ${added_value}    
    [Return]   ${total_value}    

Clear value then Input value to target field
    [Arguments]   ${obj_target_input}    ${value}
    Clear Element Text    ${obj_target_input}
    Input Text   ${obj_target_input}    ${value}

Click "%" unit
    Wait Until Element Is Visible    ${obj_invoice_details.lbl_percent_in_list}    3s
    Click Element    ${obj_invoice_details.lbl_percent_in_list}

Click "Amount" unit
    Wait Until Element Is Visible    ${obj_invoice_details.lbl_Amount_in_list}    3s
    Click Element    ${obj_invoice_details.lbl_Amount_in_list}

Get error message when select "Amount" unit and input over invoice amount by provide row
    [Arguments]   ${row}
    @{items_unit}=  Get WebElements    ${obj_invoice_details.ddl_retention_unit}
    @{items_input}=  Get WebElements    ${obj_invoice_details.ddl_retention_input}
    sleep  1s
    Click Element   ${items_unit[${row}-1]}
    Click "Amount" unit
    ${item_amount}=  Get Invoice amount in 'Invoice Details page' by provide retention amount related object    ${items_input[${row}-1]}
    ${over_amount_value}=  Evaluate    str(${item_amount}+0.01)
    Clear value then Input value to target field    ${items_input[${row}-1]}    ${over_amount_value}
    Click Element   ${items_unit[${row}-1]}
    ${error_message}=  Get Retention error message in 'Invoice Details page' by provide retention amount related object    ${items_input[${row}-1]}
    [Return]    ${error_message}

Get Invoice amount in 'Invoice Details page' by provide retention amount related object
    [Arguments]    ${obj_target_input}
    ${id}=  Get Element Attribute    ${obj_target_input}    id
    ${id_item_amount}=  Replace String    ${id}    rb_txt_gr_item_retention    rb_txt_gr_item_amount
    ${item_amount}=  Get value    id=${id_item_amount}
    [Return]    ${item_amount}    
    
Get Retention error message in 'Invoice Details page' by provide retention amount related object
    [Arguments]    ${obj_target_input}
    ${data-reactid}=  Get Element Attribute    ${obj_target_input}    data-reactid    
    ${reactid_td_retention}=  Replace String Using Regexp    ${data-reactid}    .0.0$    ${EMPTY}    
    ${obj_target_cell}=  Replace Variables    ${obj_invoice_details.lbl_error_in_retention_field}
    ${txt_error}=  Get text    ${obj_target_cell}
    [Return]    ${txt_error}  

Message error should be as expected     
    [Arguments]    ${expect_error_message}    ${actual_error_message}  
    Should Be Equal    ${expect_error_message}    ${actual_error_message}  

Click "History" button 
    [Documentation]    Click history button on view invoice detail page   
    Wait until loading complete
    Wait Until Element Is Visible    ${obj_action.history}    ${TIMEOUT}
    Click Element     ${obj_action.history}

Click 'Edit' button
    [Documentation]    Click Edit button on view invoice detail

    Wait until loading complete
    Wait Until Element Is Visible    ${obj_action.edit}    ${TIMEOUT}
    Click Element     ${obj_action.edit}    

