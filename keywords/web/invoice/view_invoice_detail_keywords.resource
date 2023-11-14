***Settings***
Variables    ../../../resources/locators/invoice/view_invoice_detail_locator.yaml

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
Click on the first row of PO Detail in view invoice page
    Wait until loading complete
    Wait Until Element Is Visible    ${obj_view_invoice_detail.tbl_po_detail.row_first}
    Click Element    ${obj_view_invoice_detail.tbl_po_detail.row_first}

Click on the first row non gr of PO Detail in view invoice page
    Wait until loading complete
    Wait Until Element Is Visible    ${obj_view_invoice_detail.tbl_po_detail.row_first_nongr}
    Scroll Element Into View   ${obj_view_invoice_detail.tbl_po_detail.row_first_nongr}
    Click Element    ${obj_view_invoice_detail.tbl_po_detail.row_first_nongr}

User input invoice number "${INVOICE_NUMBER_FROM_RETENTION}" and input date "${INVOICE_FROM_RETENTION_DATE}"
    Set invoice number with date     ${INVOICE_NUMBER_FROM_RETENTION}
    input invoice number   ${INVOICE_NUMBER_FROM_RETENTION}    1
    select invoice date    ${INVOICE_FROM_RETENTION_DATE}    1

   
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
Set invoice number with date
    [Arguments]  ${INVOICE_NUMBER_FROM_RETENTION}
    ${date}=    get current date    result_format=epoch    exclude_millis=True
    Set global variable    ${INVOICE_NUMBER_FROM_RETENTION}    ${INVOICE_NUMBER_FROM_RETENTION}${date}

Set invoice amount
    [Arguments]    ${invoice_amount} 
    Wait Until Element Is Visible    ${gr_detail.txt_invoice_amount}    ${TIMEOUT}
    
    ${count}    Get Element count    ${adjust_gr_amount['txt_amount_all_items']}
    FOR    ${index}    IN RANGE    1   ${count}+1

        ${line_item}    Set Variable    ${index}
        ${adjust_gr_amount_line_item_locator}    Replace Variables    ${adjust_gr_amount['txt_amount_line_item']}

        Double Click Element    ${adjust_gr_amount_line_item_locator} 
        Press Key    ${adjust_gr_amount_line_item_locator}     \\8    #BACKSPACE    BACKSPACE
        Input Text    ${adjust_gr_amount_line_item_locator}     ${invoice_amount} 

        ${input_amt}    Get Value    ${adjust_gr_amount_line_item_locator}
        log    ${input_amt}
     
    END    

    Click Button    ${adjust_gr_amount['btn_save']}


