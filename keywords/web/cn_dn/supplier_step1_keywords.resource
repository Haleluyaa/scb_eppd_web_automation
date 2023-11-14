*** Settings ***
Variables    ../../../resources/locators/cn_dn/step1_locator.yaml

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
Go to invoice step2 with first row of invoice step1
    Select first invoice number from invoice step1 table
    Click button create new credit note or debit note to credit note debit note step 2
    Click button next to credit note debit note step 2 

Supplier search invoice via "${first_column}" and "${second_column}" via data in row "${row_num}" 
    ${invoice_num}    Get invoice data in cell from table row and column's name    ${first_column}    ${row_num}
    ${invoice_created}   Get invoice data in cell from table row and column's name    ${second_column}    ${row_num}
    
    ${TV_invoice_num}    Set Variable    ${invoice_num}
    ${TV_invoice_created}    Set Variable    ${invoice_created}

    Set Test Variable    ${TV_invoice_num}
    Set Test Variable    ${TV_invoice_created}

    Input search criterai to text box    ${invoice_num}
    #Search invoice by date range from invoice created    ${invoice_created}
    Click search button at cndn step1

Search result data in column "${first_column}" and "${second_column}" same criteria
    ${actual_invoice_num}    Get all invoice number in table list    ${first_column}
    Search result should be same expected    ${actual_invoice_num}    ${TV_invoice_num}
    Clear search text result
       
Supplier add 2 invoice then click invoice to go to create 'Credit/Debit Note' step2
    Add invoice in sequence 1 and 2 to group cndn
    Click create new 'Credit/Debit Note' button
    Click 'Next' button to create 'Credit/Debit Note' step2 

Supplier add 1 invoice to credit/debit note then click invoice to go to create 'Credit/Debit Note' step2
    Add invoice in sequence 1 to group cndn
    Click create new 'Credit/Debit Note' button
    Click 'Next' button to create 'Credit/Debit Note' step2 

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
Clear search text result
    [Documentation]    Supplier user clear search text result

    Wait Until Element Is Visible    ${search['btn_clear_searchText']}
    Click Element    ${search['btn_clear_searchText']}
    Wait until loading complete


Create credit/debit note step1 should be shown
    [Documentation]    Verify page create credit/debit note step1 should be shown

    Wait until loading complete
    Page Should Contain Element    ${search['txt_search']}
    Page Should Contain Element    ${table_create_step1['list']}
    

Add invoice in sequence 1 and 2 to group cndn
    [Documentation]    Select checkbox in credit credit/debit note step1 at sequence 1 and 2

    Wait until loading complete
    Wait Until Element Is Visible    ${table_create_step1['chk_row_1']}    ${TIMEOUT}
    Wait Until Element Is Visible    ${table_create_step1['chk_row_2']}    ${TIMEOUT}

    Select Checkbox    ${table_create_step1['chk_row_1']} 
    Select Checkbox    ${table_create_step1['chk_row_2']}

Add invoice in sequence 1 to group cndn
    [Documentation]    Select checkbox in credit credit/debit note step1 at sequence 1

    Wait until loading complete
    Wait Until Element Is Visible    ${table_create_step1['chk_row_1']}    ${TIMEOUT}

    Select Checkbox    ${table_create_step1['chk_row_1']} 

Click create new 'Credit/Debit Note' button
    [Documentation]    Click button Create New Credit/Debit Note
    #Wait until loading complete
    Wait Until Element Is Visible      ${btn_add_new_creditdebit_note_group}    ${TIMEOUT}
    Click Element    ${btn_add_new_creditdebit_note_group}

Click 'Next' button to create 'Credit/Debit Note' step2    
    [Documentation]    Click 'Next' button to go to step2 

    Wait Until Element Is Visible    ${btn_next}    ${TIMEOUT}
    Click Button    ${btn_next}

Search result should be same expected
    [Arguments]    ${list_actual}    ${expected}
    [Documentation]    Verify search result for invoice number

    ${length}    Get Length    ${list_actual}
    FOR    ${index}    IN RANGE    0    ${length}-1
        ${actual_invoice_num}    Get From List        ${list_actual}[${index}]
        Should Be Equal As Strings    ${actual_invoice_num}    ${expected}
    END

Get invoice data in cell from table row and column's name
    [Arguments]    ${column_name}    ${row_num}
    [Documentation]    Get data in cell from selected column and row

    Wait Until Element Is Visible    ${tbl_invoice_list['table_list']}     ${TIMEOUT}
    ${target_cell}    Replace Variables    ${tbl_invoice_list['cell_by_row_and_header']}
    ${data}    Get Text    ${target_cell}

    [Return]    ${data}

Input search criterai to text box
    [Arguments]    ${search_criteria}
    [Documentation]    Input text criteria to search text box

    Wait Until Element Is Visible    ${search['txt_search']}    ${TIMEOUT}
    Clear Element Text    ${search['txt_search']}
    Input Text    ${search['txt_search']}    ${search_criteria}

Click search button at cndn step1
    [Documentation]    Click search button 

    Wait Until Element Is Visible    ${search['btn_search_text']}    ${TIMEOUT}
    Click Button      ${search['btn_search_text']}

Click search calendar icon
    [Documentation]    Click icon calendar

    Wait Until Element Is Visible    ${search['btn_search_calendar']}    ${TIMEOUT}
    Click Button    ${search['btn_search_calendar']}

Search invoice by date range from invoice created
    [Arguments]    ${invoice_created}

    Click search calendar icon
    Select search invoice date range to invoice created
    Click text box invoice created from
    Select invoice created    ${invoice_created}    ${invoice_created}

Select invoice created
    [Arguments]    ${created_date_from}    ${created_date_to}
    #Select PO Created Date Check Box
    debug
    @{created_date_from}=     Split String    ${created_date_from}    /
    Select invoice created on calendar modal    ${search['invoice_created']['txt_from']}    From    @{created_date_from}[2]    @{created_date_from}[1]     @{created_date_from}[0]
    #@{created_date_to}=     Split String    ${created_date_to}    /
    #Select invoice created on calendar modal    ${search['invoice_created']['txt_to']}    To    @{created_date_to}[2]    @{created_date_to}[1]     @{created_date_to}[0]


Select invoice created on calendar modal
    [Documentation]    This keyword is using for selecting Date picker by inputting expected year, month, date

    [Arguments]    ${expected_locator}    ${date-target}    ${expected_year}    ${expected_month}    ${expected_day}
    Wait Until Element Is Visible    ${expected_locator}
    Click Element    ${expected_locator}
    ${modal_calendar_locator}   Replace variables   ${calendar_panel}
    Wait Until Page Contains Element    ${modal_calendar_locator}
    Wait Until Element Is Visible   ${modal_calendar_locator}

    ${current_date_format} =    Get Current Date    result_format=datetime
    ${current_day} =    Set Variable    ${current_date_format.day}
    ${current_month} =    Set Variable    ${current_date_format.month}
    ${current_year} =    Set Variable    ${current_date_format.year}

    ${year_diff}=   Evaluate    int("${expected_year}")-int("${current_year}")
    ${month_diff}=  Evaluate    int("${expected_month}")-int("${current_month}")

    Run Keyword If  ${year_diff} < 0    Multiple Click On Previous Year Button Created Date    ${year_diff}    ${expected_calendar}
    Run Keyword If  ${year_diff} > 0    Multiple Click On Next Year Button Created Date    ${year_diff}    ${expected_calendar}

    Run Keyword If  ${month_diff} < 0    Multiple Click On Previous Month Button Created Date    ${month_diff}    ${expected_calendar}
    Run Keyword If  ${month_diff} > 0    Multiple Click On Next Month Button Created Date    ${month_diff}    ${expected_calendar}

    ${select_day}=    Convert To Integer   ${expected_day}
    ${modal_calendar_date_locator}   Replace variables   ${mdl_calendar_date}
    ${modal_calendar_date_select_locator}   Replace variables   ${mdl_calendar_date_select}
    Scroll Element Into View    ${modal_calendar_date_locator}
    Click Element   ${modal_calendar_date_select_locator}

Multiple Click On Next Year Button Created Date
    [Arguments]     ${click_times}    ${calendar_type}
    [Documentation]    Click Next Year

    FOR    ${INDEX}    IN RANGE    0    ${click_times}
        ${btn_year_locator}     Replace variables   ${mdl_calendar_btn_month}
        ${btn_next_year_locator}     Replace variables   ${btn_next_year}    
        Scroll Element Into View    ${btn_year_locator}
        Click Element      ${btn_next_year_locator}
    END

Multiple Click On Previous Year Button Created Date
    [Arguments]     ${click_times}    ${calendar_type}
    [Documentation]    Click Previous Year

    ${click_times}=     Evaluate    abs(${click_times})
     FOR    ${INDEX}    IN RANGE    0    ${click_times}
        ${btn_year_locator}     Replace variables   ${mdl_calendar_btn_month}
        ${btn_prev_year_locator}     Replace variables   ${btn_prev_year}
        Scroll Element Into View    ${btn_year_locator}
        Click Element    ${btn_prev_year_locator}
    END

Multiple Click On Next Month Button Created Date
    [Arguments]     ${click_times}    ${calendar_type}
    [Documentation]    Click Next Month

    FOR    ${INDEX}    IN RANGE    0    ${click_times}
        ${btn_mon_locator}     Replace variables   ${mdl_calendar_btn_month}
        ${btn_next_month_locator}     Replace variables   ${btn_next_month}
        Scroll Element Into View    ${btn_mon_locator}
        Click Element    ${btn_next_month_locator}
    END

Multiple Click On Previous Month Button Created Date
    [Arguments]     ${click_times}    ${calendar_type}
    [Documentation]    Click Previous Month

    ${click_times}=    Evaluate    abs(${click_times})
    FOR    ${INDEX}    IN RANGE    0    ${click_times}
        ${btn_mon_locator}     Replace variables   ${mdl_calendar_btn_month}
        ${btn_prev_month_locator}     Replace variables   ${btn_prev_month}    
        Scroll Element Into View    ${btn_mon_locator}
        Click Element    ${btn_prev_month_locator}
    END

Get all invoice number in table list
    [Arguments]    ${column_name}

    [Documentation]    Get invoice number that show in list

    Wait until loading complete
    ${column_target}    Replace Variables    ${tbl_invoice_list['column_by_header']}  

    Wait Until Element Is Visible     ${column_target}

    @{list_invoice_num}    Create List

    ${count}    Get Element Count    ${column_target}
    FOR    ${index}    IN RANGE    0    ${count}
        ${invoice_num}    Get Text    ${column_target}
        Append To List    ${list_invoice_num}    ${invoice_num}
    END
    [Return]    @{list_invoice_num}       

Select search invoice date range to any time    
    [Documentation]    Selected search invoice by criteria date in Any Time

    Wait Until Element Is Visible    ${search['date_range']['any_time']}    ${TIMEOUT}
    Click Element    ${search['date_range']['any_time']}

Select search invoice date range to invoice created 
    [Documentation]    Selected search invoice by criteria data to Invoice Created   

    Wait Until Element Is Visible    ${search['date_range']['invoice_created']}    ${TIMEOUT}
    Click Element    ${search['date_range']['invoice_created']}

Click text box invoice created from
    [Documentation]    Click text box invoice create from

    Wait Until Element IS Visible    ${search['invoice_created']['txt_from']}    ${TIMEOUT}
    Click Element    ${search['invoice_created']['txt_from']}

Click text box invoice created to
    [Documentation]    Click text box invoice created to

    Wait Until Element IS Visible    ${search['invoice_created']['txt_to']}    ${TIMEOUT}
    Click Element    ${search['invoice_created']['txt_to']}

Select invoice list from table header
    [Documentation]    select invoice for create cn/dn from table header
    Wait until element is visible    ${chk_invoice_cndn_table_header_locator}
    Click element    ${chk_invoice_cndn_table_header_locator}

Search invoice number via ${keyword} and option equal invoice number  
    [Documentation]    search invoice number by keyword search and option is invoice number
    Wait until element is visible    ${txt_search_add_credit_debit_locator}
    Input text    ${txt_search_add_credit_debit_locator}    ${keyword}
    Click element    ${btn_search_add_credit_debit_locator} 

Click button next to credit note debit note step 2
    [Documentation]    click next button in credit note/ debit note step 1 to step 2
    Wait until element is visible    ${btn_next_to_step2_enable_locator}
    Click element    ${btn_next_to_step2_enable_locator}

Click button create new credit note or debit note to credit note debit note step 2    
    [Documentation]    click create new credit note/ debit note button for add invoice to new credit note
    Wait until element is visible    ${btn_add_invoice_enabled_locator}
    Click element    ${btn_add_invoice_enabled_locator}

Select first invoice number from invoice step1 table
    [Documentation]    checked on check box at invoice table step1
    ${chk_invoice_number_body_specificed_row_locator}    Replace ${chk_invoice_number_body_specificed_row_locator} from REPLACE_ME to 1
    Wait until element is visible    ${chk_invoice_number_body_specificed_row_locator} 
    Click element    ${chk_invoice_number_body_specificed_row_locator}    

    