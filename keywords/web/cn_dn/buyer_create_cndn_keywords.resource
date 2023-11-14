*** Settings ***
Variables    ../../../resources/locators/cn_dn/buyer_create_cndn_locator.yaml

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

create online cndn for use with request document and set to 'CNDN_NUMBER_TO_REQUEST_DOCUMENT'
    Go to menu manage CN/DN
    User create CNDN with buyer "${FULL_BUYER_NAME_TRUE}" supplier "${SUPPLIER_NAME_AIS}" currency "${ALL_CURRENCY_EN}"
    Search invoice on cndn create step1 by keyword equal "${INV_NUMBER_FOR_REQ_CNDN}"
    Select invoice at first row and Create new CNDN
    Go to Invoice details row '1' of CNDN row '1'
    Input '${CNDN_AMOUNT_FOR_REQ}' at item no. '1'
    Save data on "Invoice Details"
    Gen CNDNNumber and CNDNDate
    #Input CNDN Number ${CNDN_NUMBER_TO_REQUEST_DOCUMENT} at row '1', CNDN date ${CNDN_DATE_TO_REQUEST_DOCUMENT} at row '1'
    Input CNDN Number ${CNDN_NUMBER_TO_REQUEST_DOCUMENT} at row '1' and CNDN date to current date at row '1'
    Submit CNDN
    Set CNDN ${CNDN_NUMBER_TO_REQUEST_DOCUMENT} to online CNDN

User create CNDN with buyer "${buyer_name}" supplier "${supplier_name}" currency "${currency_name}"
    Click "Create New CNDN" button
    Click "Select Invoice" button
    Click on buyer dropdownlist
    Input value to "Buyer Search" text field    ${buyer_name}
    Select buyer        ${buyer_name}
    Click on supplier dropdownlist
    Input value to "Supplier Search" text field    ${supplier_name}
    Select supplier     ${supplier_name}
    Click on currency dropdownlist
    Select currency     ${currency_name}
    Click "Next" button to "Create CNDN"

Create a CNDN offline with status 'Awaiting Approval'
    Go to menu manage CN/DN
    User create CNDN with buyer "${FULL_BUYER_NAME_TRUE}" supplier "${SUPPLIER_NAME_AIS}" currency "${ALL_CURRENCY_EN}"
    Search invoice on cndn create step1 by keyword equal "${INV_NUMBER_FOR_REQ_CNDN}"
    Select invoice at first row and Create new CNDN
    Go to Invoice details row '1' of CNDN row '1'
    Input '${CNDN_AMOUNT_FOR_REQ}' at item no. '1'
    Save data on "Invoice Details"
    Gen CNDNNumber and CNDNDate
    Input CNDN Number ${CNDN_NUMBER_TO_REQUEST_DOCUMENT} at row '1', CNDN date ${CNDN_DATE_TO_REQUEST_DOCUMENT} at row '1'
    Submit CNDN
    Set test variable   ${CNDN_NUMBER_EDIT_ATTACHMENT_AND_APPROVE}  ${CNDN_NUMBER_TO_REQUEST_DOCUMENT}
    Set test variable   ${EDIT_ATTACHMENT_DUEDATE}  ${CNDN_DATE_TO_REQUEST_DOCUMENT}

create offline cndn for use with close cndn and set to 'CNDN_NUMBER_TO_CLOSE_CNDN_LV1'
    Go to menu manage CN/DN
    User create CNDN with buyer "${FULL_BUYER_NAME_TRUE}" supplier "${SUPPLIER_NAME_AIS}" currency "${ALL_CURRENCY_EN}"
    Search invoice on cndn create step1 by keyword equal "${INV_NUMBER_FOR_REQ_CNDN}"
    Select invoice at first row and Create new CNDN
    Go to Invoice details row '1' of CNDN row '1'
    Input '${CNDN_AMOUNT_FOR_REQ}' at item no. '1'
    Save data on "Invoice Details"
    Gen CNDNNumber and CNDNDate
    Input CNDN Number ${CNDN_NUMBER_TO_REQUEST_DOCUMENT} at row '1', CNDN date ${CNDN_DATE_TO_REQUEST_DOCUMENT} at row '1'
    Submit CNDN    
    Set test variable   ${CNDN_NUMBER_TO_CLOSE_CNDN_LV1}     ${CNDN_NUMBER_TO_REQUEST_DOCUMENT}

create offline cndn for use with close cndn and set to 'CNDN_NUMBER_TO_CLOSE_CNDN_LV1' via buyer
    Go to menu manage CN/DN
    User create CNDN with buyer "${FULL_BUYER_NAME_TRUE}" supplier "${SUPPLIER_NAME_AIS}" currency "${ALL_CURRENCY_EN}"
    Search invoice on cndn create step1 by keyword equal "${INV_NUMBER_FOR_REQ_CNDN}"
    Select invoice at first row and Create new CNDN
    Go to Invoice details row '1' of CNDN row '1'
    Input '${CNDN_AMOUNT_FOR_REQ}' at item no. '1'
    Save data on "Invoice Details"
    Gen CNDNNumber and CNDNDate
    Input CNDN Number ${CNDN_NUMBER_TO_REQUEST_DOCUMENT} at row '1', CNDN date ${CNDN_DATE_TO_REQUEST_DOCUMENT} at row '1'
    Submit CNDN    
    Set test variable   ${CNDN_NUMBER_TO_CLOSE_CNDN_LV1}     ${CNDN_NUMBER_TO_REQUEST_DOCUMENT}    

Search invoice on cndn create step1 by keyword equal "${keyword}"
    Search invoice by search keyword    ${keyword}

Select invoice at first row and Create new CNDN
    Select invoice By Selected Row    1
    Click "Create New CNDN" button on step1
    Click "Next" button to summary invoice of CNDN

Go to Invoice details row '${inv_row}' of CNDN row '${cndn_row}' 
    Click on invoice drew down to 'Invoice Details' at row      ${inv_row}  ${cndn_row}
    Verify invoice details page  

Save data on "Invoice Details"
    Sleep   5s
    ${v1}     Get Value    (//*[contains(@id,'rb_txt_gr_item_amount')])[1]
    ${v2}     Get Value    (//*[contains(@id,'rb_txt_gr_item_amount')])[2]
    ${v3}     Get Value    (//*[contains(@id,'rb_txt_gr_item_amount')])[3]
    Log to console      ${v1}#${v2}#${v3}--1
    Click on save button 
    Verify create cndn step2 page
    Verify adjust amount correctly on cndn step2    ${CNDN_AMOUNT_FOR_REQ}

Gen CNDNNumber and CNDNDate
    ${date_create_date}=        Get Current Date    result_format=%Y%m%d%H%M
    ${string_create_date}       Convert To String   ${date_create_date}    
    ${date_create_date_2}=      Get Current Date    result_format=%Y-%m-%d
    ${string_create_date_2}     Convert To String   ${date_create_date_2}  
    ${Gen_CNDNNumber}=       Set Variable       C${string_create_date}
    ${Gen_CNDNDate}=         Set Variable       '${string_create_date_2} 00:00:00.000'
    set test variable   ${CNDN_NUMBER_TO_REQUEST_DOCUMENT}     ${Gen_CNDNNumber}
    set test variable   ${CNDN_DATE_TO_REQUEST_DOCUMENT}     ${Gen_CNDNDate}

Input '${amt}' at item no. '${row_num}'
    Click on CNDN amount on invoice items row   ${row_num}
    Input value to "CNDN Amount" on invoice items row     ${amt}      ${row_num}

Input CNDN Number ${CNDN} at row '${CNDNnumrow}', CNDN date ${CNDNDate} at row '${CNDNdaterow}'
    Input CNDN Number        ${CNDN}        ${CNDNnumrow}
    Sleep   1s
    Select CNDN Date at current date         ${CNDNDate}          ${CNDNdaterow}

Input CNDN Number ${CNDN} at row '${CNDNnumrow}' and CNDN date to current date at row '${CNDNdaterow}'
    Input CNDN Number        ${CNDN}        ${CNDNnumrow}
    Select 'CNDN Date' to current date    ${CNDNdaterow}

Submit CNDN
    Click on submit button
    Click on 'Yes button' to submit CNDN    

Set CNDN ${cndn_num_for_req} to online CNDN
    Set value to field 'Invoice Type' in DB     ${cndn_num_for_req}     ${CNDN_ONLINE_ID}

Set CNDN ${cndn_num_for_req} back to offline CNDN
    Set value to field 'Invoice Type' in DB     ${cndn_num_for_req}     ${CNDN_OFFLINE_ID}

Verify create cndn step2 page
   Verify displaying of navigator step 2 must be actived
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
Verify displaying of navigator step 2 must be actived
    Wait Until Element Is Visible    ${ico_step_last}
    Element Should Be Visible    ${ico_step_last}    

Verify adjust amount correctly on cndn step2    
    [Arguments]     ${amt}
    ${lbl_amount_cndn}  Replace variables   ${lbl_amount_cndn}
    Wait Until Element Is Visible   ${lbl_amount_cndn}
    Element Should Be Visible   ${lbl_amount_cndn}

Click "Create New CNDN" button
    Wait Until Element Is Visible    ${btn_create_cndn}    ${TIMEOUT}
    Click Element    ${btn_create_cndn}

Click "Select Invoice" button
    Wait Until Element Is Visible    ${btn_select_inv}    ${TIMEOUT}
    Click Element    ${btn_select_inv}

Input value to "Buyer Search" text field
    [Arguments]    ${search_criteria}
    Wait Until Element Is Visible    ${txt_search_buyer}    ${TIMEOUT}
    Input Text    ${txt_search_buyer}    ${search_criteria}

Input value to "Supplier Search" text field
    [Arguments]    ${search_criteria}
    Wait Until Element Is Visible    ${txt_search_supplier}    ${TIMEOUT}
    Input Text    ${txt_search_supplier}    ${search_criteria}

Click on buyer dropdownlist
    Wait Until Element Is Visible    ${ddl_selected_buyer_offline}    ${TIMEOUT}
    Click Element    ${ddl_selected_buyer_offline}

Click on supplier dropdownlist
    Wait Until Element Is Visible    ${ddl_selected_supplier_offline}    ${TIMEOUT}
    Click Element    ${ddl_selected_supplier_offline}

Click on currency dropdownlist
    Wait Until Element Is Visible    ${ddl_selected_currency_offline}    ${TIMEOUT}
    Click Element    ${ddl_selected_currency_offline}

Click "Next" button to "Create CNDN"
    Wait Until Element Is Visible    ${btn_continue}    ${TIMEOUT}
    Click Element    ${btn_continue}

Select buyer
    [Arguments]    ${selected_value}
    Wait Until Element Is Visible    ${ddl_search_buyer_offline}    ${TIMEOUT}
    ${selected_buyer}   Replace variables   ${select_buyer}
    Click Element    ${selected_buyer}

Select supplier
    [Arguments]    ${selected_value}
    Wait Until Element Is Visible    ${ddl_search_supplier_offline}    ${TIMEOUT}
    ${selected_supplier}   Replace variables   ${select_supplier}
    Click Element    ${selected_supplier}

Select currency
    [Arguments]    ${selected_value}
    Wait Until Element Is Visible    ${ddl_currency_offline_list}    ${TIMEOUT}
    ${selected_currency}   Replace variables   ${select_currency}
    Click Element    ${selected_currency}

Click "Next" button to summary invoice of CNDN
    Wait Until Element Is Enabled    ${btn_next_step1}    ${TIMEOUT}
    Click Element    ${btn_next_step1}  

Select invoice By Selected Row
    [Arguments]    ${row}
    ${chb_inv_list_with_row}    Replace variables   ${chb_inv_list_with_row}
    Wait Until Element Is Visible    ${chb_inv_list_with_row}    ${TIMEOUT}
    Wait Until Page Contains Element    ${chb_inv_list_with_row}    ${TIMEOUT}
    Select Checkbox    ${chb_inv_list_with_row}

Search invoice by search keyword
    [Arguments]    ${keyword_search}
    Run keyword if      '${keyword_search}' != 'none'   Run Keywords
    ...     Wait Until Element Is Visible    ${txt_input_criteria}     ${timeout}
    ...     AND     clear element text  ${txt_input_criteria}
    ...     AND     Input Text    ${txt_input_criteria}    ${keyword_search}
    ...     AND     Click Element    ${btn_search_button}
    ...     AND     Wait until loading complete   

Click "Create New CNDN" button on step1
    Wait Until Element Is Visible    ${btn_create_invoice_step1}    ${TIMEOUT}
    Click Element    ${btn_create_invoice_step1}

Click on invoice drew down to 'Invoice Details' at row      
    [Arguments]     ${inv_row}      ${cndn_row} 
    ${btn_inv_detail}   Replace variables   ${btn_inv_detail}
    Wait Until Element Is Visible    ${btn_inv_detail}    ${TIMEOUT}
    Click Element    ${btn_inv_detail}

Click on CNDN amount on invoice items row   
    [Arguments]     ${row_num}    
    ${txt_cndn_amt}   Replace variables   ${txt_cndn_amt}
    Wait Until Element Is Visible    ${txt_cndn_amt}    ${TIMEOUT}
    Click Element    ${txt_cndn_amt}

Input value to "CNDN Amount" on invoice items row     
    [Arguments]     ${amt}      ${row_num}
    ${txt_cndn_amt}   Replace variables   ${txt_cndn_amt}
    Double Click Element    ${txt_cndn_amt}
    Sleep   0.5s
    Press keys    ${txt_cndn_amt}    CTRL+A
    Press keys    ${txt_cndn_amt}    CTRL+X
    click element     ${txt_cndn_amt}    DELETE
    
    Input Text    ${txt_cndn_amt}    ${amt} 

verify invoice details page
    Wait Until Element Is Visible   ${lbl_inv_details_header}   ${TIMEOUT}

Click on save button 
    Wait Until Element Is Visible    ${btn_inv_detail_save}    ${TIMEOUT}
    Click Element    ${btn_inv_detail_save}

Input CNDN Number        
    [Arguments]    ${CNDNNumber}         ${row}
    ${cndnnum_with_row}=    Replace variables   ${txt_cndn_number}
    Wait Until Element Is Visible    ${cndnnum_with_row}
    Input Text    ${cndnnum_with_row}    ${CNDNNumber}    

Select 'CNDN Date' to current date
    [Arguments]    ${row}
    [Documentation]    Select CNDN Date on current date
    
    #Click text box cndn date
    ${locator_txt_cndn_date}     Replace variables   ${txt_cndn_date}
    Wait Until Element Is Visible    ${locator_txt_cndn_date}    ${TIMEOUT}
    Click Element       ${locator_txt_cndn_date}

    #Click current date in calendar
    Wait Until Element Is Visible    ${calendar_menu['cell_current_date']}    ${TIMEOUT}
    Click Element    ${calendar_menu['cell_current_date']}


Select CNDN Date         
    [Arguments]    ${CNDNdate}   ${row}
    #Convert Date Format
    ${CNDNdate}=    Convert Date    ${CNDNdate}    result_format=%Y-%m-%d
    ${CNDNdate_wo_zero}=    convert_today_to_string_without_zeropad     %Y-%#m-%#d
    #Get month and year
    ${month_txt}=    Convert Date    ${CNDNdate}    result_format=%B
    ${year_txt}=    Convert Date    ${CNDNdate}    result_format=%Y

    ${locator_txt_cndn_date}     Replace variables   ${txt_cndn_date}
    Wait Until Element Is Visible    ${locator_txt_cndn_date}    ${TIMEOUT}
    Click Element       ${locator_txt_cndn_date}

    #Select Month
    :FOR    ${i}    IN RANGE    999999
    \    ${month_checker}=    Run Keyword And Return Status    Element Should Contain   ${calendar_menu.spn_month_select}    ${month_txt}
    \    Exit For Loop If    ${month_checker} == True
    \    Wait Until Element Is Visible         ${calendar_menu.btn_previous_month}    ${TIMEOUT}
    \    Click element     ${calendar_menu.btn_previous_month}
    #Select Year
    :FOR    ${i}    IN RANGE    999999
    \    ${year_checker}=    Run Keyword And Return Status    Element Should Contain   ${calendar_menu.spn_year_select}    ${year_txt}
    \    Exit For Loop If    ${year_checker} == True
    \    Wait Until Element Is Visible         ${calendar_menu.btn_previous_year}    ${TIMEOUT}
    \    Click element     ${calendar_menu.btn_previous_year}
    #Select Date
    Execute Javascript    document.querySelector("td[title='${CNDNdate_wo_zero}'] > div").click()    

Select CNDN Date at current date         
    [Arguments]    ${CNDNdate}   ${row}

    ${locator_txt_cndn_date}     Replace variables   ${txt_cndn_date}
    Wait Until Element Is Visible    ${locator_txt_cndn_date}    ${TIMEOUT}
    Click Element       ${locator_txt_cndn_date}
    Click Element    //div[@class="rc-calendar-date"][@aria-selected="true"]
      
Click on submit button
    Wait until loading complete
    Wait Until Element Is Visible    ${btn_footer_submit}
    Click Button    ${btn_footer_submit}

Click on 'Yes button' to submit CNDN 
    Wait Until Element Is Visible    ${btn_footer_submit_yes}
    Click Element    ${btn_footer_submit_yes}
    
Set value to field 'Invoice Type' in DB
    [Arguments]     ${CNDNNumber}   ${InvType}
    ${sql_cndn_type}=    Get query string for UPDATE 'CNDN' for set 'InvoiceType' where with 'CNDNNum'    ${CNDNNumber}    ${InvType}
    ${return_status_1}=  eInvoice Execute INSERT, UPDATE, DELETE query string    ${sql_cndn_type}  