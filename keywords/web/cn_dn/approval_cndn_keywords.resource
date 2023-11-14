*** Settings ***
Variables    ../../../resources/locators/cn_dn/buyer_cndn_list_locator.yaml

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
Go to menu approval CN/DN
    Wait until loading complete
    approval_cndn_keywords.Click on 'CN/DN' menu on left side
    Click on approval CN/DN menu
    Verify page 'CN/DN' display

Get target CN/DN No. at column "${column_name}" at row "${row_num}"
    ${column_target}=    Set Variable    ${column_name}
    ${ret_col_no}=  Get column number by target column name    ${column_target}    ${obj_cndn_status.cndn_status_section.tbl_cndn_buyer_result_header_row}
    ${ret_col_no}=    Evaluate    ${ret_col_no} + 1
    ${target_obj}=    Replace Variables     ${obj_cndn_status.cndn_status_section.tbl_cndn_buyer_firstrow_with_columm}
    ${cndn_no}=     Get Text    ${target_obj}
    Set Test Variable    ${cndn_no}

Set value in DB for 'CN/DN status' as "${cndn_status}"
    Get target CN/DN Status and set variable 'original cndn status'
    Update value to field 'CN/DN status' in DB    ${cndn_status}    '${cndn_no}'     

Get target CN/DN Status and set variable 'original cndn status'     
    ${cndn_status}=  Get CN/DN status from 'CN/DN' table in DB    '${cndn_no}'
    Set Test Variable    ${original_cndn_status}     ${cndn_status}

Click first row of CN/DN at column "${column_name}"
    approval_cndn_keywords.Table CN/DN should have at least one row
    approval_cndn_keywords.Click on first row of 'CN/DN' table    ${column_name}

Click on first row of 'CN/DN' no show information needed at column "${column_name}"    
    approval_cndn_keywords.Table CN/DN should have at least one row
    ${select_cndn_num}    Get first 'CN/DN' not information needed
    #Click on specific 'CN/DN' from column
    Click on specific 'CN/DN' from column  ${select_cndn_num}  ${column_name}

Search CN/DN with status "${cndn_status}"
    approval_cndn_keywords.Click 'Status' dropdown list
    approval_cndn_keywords.Click on target status    ${cndn_status}

User select CN/DN with status '${status}'
    Click 'Status' dropdown list
    Table CN/DN should have at least one row
    Click on target status    ${status}
    Click on first row of 'CN/DN' table    ${TEXT.BUYER}

User select CN/DN with status 'Approved'
    Click 'Status' dropdown list
    Table CN/DN should have at least one row
    Click on target status    Approved
    Click on first row of 'CN/DN' table    ${TEXT.BUYER}

User select CN/DN with status 'Rejected'
    Click 'Status' dropdown list
    Table CN/DN should have at least one row
    Click on target status    Rejected
    Click on first row of 'CN/DN' table    ${TEXT.BUYER}

User select CN/DN with status 'Processing'
    Click 'Status' dropdown list
    Table CN/DN should have at least one row
    Click on target status    Processing
    Click on first row of 'CN/DN' table    ${TEXT.BUYER}

User select CN/DN with Buyer name "${buyer_name}" and status 'Approved'
    Click 'filter' dropdown list
    Click on target filter     Buyer
    input search keyword    ${BUYER_NAME}
    Click search button
    Click 'Status' dropdown list
    Table CN/DN should have at least one row
    Click on target status    Approved
    Click on first row of 'CN/DN' table    ${TEXT.BUYER}

User select CN/DN with Buyer name "${buyer_name}" and status 'Rejected'
    Click 'filter' dropdown list
    Click on target filter     Buyer
    input search keyword     ${BUYER_NAME}
    Click search button
    Click 'Status' dropdown list
    Table CN/DN should have at least one row
    Click on target status    Rejected
    Click on first row of 'CN/DN' table    ${TEXT.BUYER}

User select CN/DN with Buyer name "${buyer_name}" and status 'Awaiting'
    Click 'filter' dropdown list
    Click on target filter     Buyer
    input search keyword    ${BUYER_NAME}
    Click search button
    Click 'Status' dropdown list
    Table CN/DN should have at least one row
    Click on target status    Awaiting
    Click on first row of 'CN/DN' table    ${TEXT.BUYER}

Search filter is visible
    Verify page 'CN/DN' filter

Default filter should be 'CN/DN' and status filter should be 'All Status'
    Check default value of filter    CN/DN
    Check default value of status    All Status

User select status filter 'Awaiting'
    Click 'Status' dropdown list
    Click on target status    Awaiting

User select status filter 'Approved​'
    Click 'Status' dropdown list
    Click on target status    Approved

User select status filter 'Rejected'
    Click 'Status' dropdown list
    Click on target status    Rejected

User select status filter 'Processing'
    Click 'Status' dropdown list
    Click on target status    Processing

System should display all CN/DN that have status 'Awaiting' 
    Table CN/DN should have at least one row
    Verify status of CN/DNs results    Awaiting 

System should display all CN/DN that have status 'Approved​'
    Table CN/DN should have at least one row
    Verify status of CN/DNs results    Approved 

System should display all CN/DN that have status 'Rejected'
    Table CN/DN should have at least one row
    Verify status of CN/DNs results     Rejected 

System should display all CN/DN that have status 'Processing'
    Table CN/DN should have at least one row
    Verify status of CN/DNs results    Processing 

User select CN/DN search filter and enter CN/DN number "${cndn_number}" in search textbox
    Click 'filter' dropdown list
    Click on target filter    ${TEXT.FILTER_CNDN_NUMBER}    
    input search keyword    ${cndn_number}
    Click search button

User select Invoice Number​ filter and enter Invoice Number​ "${invoice_number}" in search textbox
    Click 'filter' dropdown list
    Click on target filter     ${TEXT.INVOICE_NUMBER}
    input search keyword    ${invoice_number}
    Click search button

User select Reference Number​ filter and enter Reference Number​ "${reference_number}" in search textbox
    Click 'filter' dropdown list
    Click on target filter    ${TEXT.REF_NO}
    input search keyword    ${reference_number}
    Click search button

User select Buyer filter and enter Buyer​ name "${BUYER_NAME}" in search textbox
    Click 'filter' dropdown list
    Click on target filter    ${TEXT.BUYER}
    input search keyword    ${buyer_name}
    Click search button

User select Supplier​ filter and enter Supplier​ name "${SUPPLIER​_NAME}" in search textbox
    Click 'filter' dropdown list
    Click on target filter     ${TEXT.SUPPLIER}
    input search keyword    ${supplier​_name}
    Click search button

System should display all CN/DN that have CN/DN Number "${cndn_number}"
    Table CN/DN should have at least one row
    Verify filtered CN/DN results    ${TEXT.CNDN_NUMBER}     ${cndn_number}

System should display all CN/DN that have Invoice Number​ "${invoice_number}"
    Verify filtered CN/DN results    ${TEXT.INVOICE_NUMBER}     ${INVOICE_NUMBER}
    
System should display all CN/DN that have Reference Number​ "${reference_number}"
    Verify filtered CN/DN results    ${TEXT.REF_NO}     ${REFERENCE_NUMBER}
    
System should display all CN/DN that have Buyer​ name "${BUYER_NAME}"
    Verify filtered CN/DN results    ${TEXT.BUYER}     ${BUYER_NAME}
    
System should display all CN/DN that have Supplier​ name "${SUPPLIER_NAME}"
    Verify filtered CN/DN results    ${TEXT.SUPPLIER}     ${SUPPLIER_NAME}
    
User click calendar in search textbox
    Click calendar button

Select 'Any time' date range
    Click 'Any time' radio button

Select 'Received Date' date range
    Click 'Received Date' radio button

Default calendar selection should be 'Any Time'
    Anytime radio button is selected

User select from date "${cndn_from_date}" and to date "${cndn_to_date}"
    Select from date   ${cndn_from_date}
    Select to date   ${cndn_to_date} 
    
System should display all CN/DN that have status 'Awaiting' and Received Date from date "${cndn_from_date}" and to date "${cndn_to_date}"
    Verify status of CN/DNs results    Awaiting
    Table CN/DN should have at least one row
    Verify Received Date of CN/DNs results    ${cndn_from_date}     ${cndn_to_date}    Awaiting  

'Invalid date' message should be appear at to date selector
    Check date alert message
     
System should display 'No results found.'
    'No results found' message is visible

The system must be redirect to list and success bar is "${success_bar_msg}" and show search on "${cndn_number}" and status is "${cndn_number_status}"
    [Documentation]    Verify the data that reject credit/debit note is completed
                ...    That redirect to list page, display success bar and display data from search

    Success bar for reject credit/debit note must be    ${success_bar_msg}    ${cndn_number}
    Credit/Debit Note from search result must be    ${cndn_number}
    Credit/Debit note status must be    ${cndn_number_status}         

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
Click on 'CN/DN' menu on left side
    Wait Until Element Is Visible         ${obj_cndn_status.right_menu.lnk_cndn_menu}    ${TIMEOUT}
    Click Element    ${obj_cndn_status.right_menu.lnk_cndn_menu}

Click on approval CN/DN menu
    Wait Until Element Is Visible         ${obj_cndn_status.right_menu.lnk_approve_cndn_menu}    ${TIMEOUT}
    Click Element    ${obj_cndn_status.right_menu.lnk_approve_cndn_menu}
    
Verify page 'CN/DN' display
    Wait Until Element Is Visible    ${obj_cndn_status.cndn_status_section.tab_approve_cndn}    ${TIMEOUT}

Table CN/DN should have at least one row
    ${row_count}=    Get Element Count    ${obj_cndn_status.cndn_status_section.tbl_cndn_buyer_result_row}
    Should Be True    ${row_count} > 0

Click on first row of 'CN/DN' table
    [Arguments]    ${column_name}
    ${column_target}=    Set Variable    ${column_name}
    ${ret_col_no}=  Get column number by target column name    ${column_target}    ${obj_cndn_status.cndn_status_section.tbl_cndn_buyer_result_header_row}
    ${ret_col_no}=    Evaluate    ${ret_col_no} + 1
    ${target_obj}=    Replace Variables     ${obj_cndn_status.cndn_status_section.tbl_cndn_buyer_firstrow_with_columm}    #${ret_col_no}
    Click Element    ${target_obj}

Click on specific 'CN/DN' from column
    [Arguments]    ${cndn_num}    ${column_name}

    ${column_target}=    Set Variable    ${column_name}
    ${ret_col_no}=  Get column number by target column name    ${column_target}    ${obj_cndn_status.cndn_status_section.tbl_cndn_buyer_result_header_row}
    ${ret_col_no}=    Evaluate    ${ret_col_no} + 1

    ${target_object}    Replace Variables    ${obj_cndn_status.cndn_status_section.tbl_cndn_buyer_selected_cndn_firstrow_with_column}

    Click Element    ${target_object}

Get first 'CN/DN' not information needed
    [Documentation]    Get first CN/DN Number not show icon information needed
                ...    Via compare CN/DN Information needed with all CN/DN display in page
    ${cndn_need_info}    Get Webelements    ${obj_cndn_status['cndn_status_section']['tbl_cndn_num_buyer_row_infomation_needed']}    #//*[@id="rb-tbl-buyer-credit-note"]/tbody/tr//td[@class="buyer-inv-num" and a[(@class="pending op-tooltip")]]
    ${cndn_all_in_page}    Get Webelements    ${obj_cndn_status['cndn_status_section']['tbl_cndn_num_buyer_all']}    #//*[@id="rb-tbl-buyer-credit-note"]/tbody/tr//td[@class="buyer-inv-num"]
    
    ${needed}    Get data have information needed    ${cndn_need_info}

    FOR    ${index}    IN    @{cndn_all_in_page}

            ${element}    Get Text    ${index}
            ${count}    Get Matches    ${needed}    ${element}
            ${status}    Run Keyword If     ${count}==[]   Exit For Loop
            
    END
    [Return]    ${element}

Get data have information needed    
    [Arguments]    ${web_element}

    @{list}    Create List
    FOR    ${item}    IN    @{web_element}
        ${data}    Get Text    ${item}
        Append To List    ${list}    ${data}
    END

    [Return]    ${list}

Click 'Status' dropdown list
    Wait Until Element Is Visible    ${obj_cndn_status.cndn_status_section.ddl_buyer_cndn_status}   ${TIMEOUT} 
    Click Element    ${obj_cndn_status.cndn_status_section.ddl_buyer_cndn_status}

Click 'filter' dropdown list
    Wait Until Element Is Visible    ${obj_cndn_status.cndn_search_filter_section.ddl_cndn_filter}   ${TIMEOUT} 
    Click Element    ${obj_cndn_status.cndn_search_filter_section.ddl_cndn_filter}

Click on target status
    [Arguments]   ${cndn_status}
    ${selected_approval_status}=    Set Variable    ${cndn_status}
    ${target_obj}=    Replace Variables     ${obj_cndn_status.cndn_status_section.lbl_buyer_cndn_status}  
    Wait Until Element Is Visible   ${target_obj}   ${TIMEOUT}
    Click Element    ${target_obj}
    Wait until loading complete

Click on target filter
    [Arguments]   ${cndn_filter}
    ${target_obj}=    Replace Variables     ${obj_cndn_status.cndn_search_filter_section.lbl_cndn_filter}  #${cndn_filter}
    Wait Until Element Is Visible    ${target_obj}   ${TIMEOUT}
    Click Element    ${target_obj}

Input search keyword
    [Arguments]   ${search_keyword}
    Input Text    ${obj_search.txt_search}    ${search_keyword}

Click search button
    Click Element    ${obj_search.btn_search}

Verify page 'CN/DN' filter
    Wait Until Element Is Visible         ${obj_cndn_status.cndn_search_filter_section.ddl_cndn_filter}    ${TIMEOUT}

Check default value of filter
    [Arguments]   ${cndn_filter}
    ${target_obj}=    Replace Variables     ${obj_cndn_status.cndn_search_filter_section.lbl_cndn_filter}  #${cndn_filter}
    
Check default value of status
    [Arguments]   ${cndn_status}
    ${target_obj}=    Replace Variables     ${obj_cndn_status.cndn_status_section.lbl_buyer_cndn_status}  #${cndn_status}

Verify status of CN/DNs results 
    [Arguments]   ${cndn_status}
    @{list}=   Get Dictionary values   ${STATUS}
    Remove Values From List     ${list}     ${cndn_status}
    :FOR    ${element}    IN    @{list}
    \       Element Should Not Contain    ${obj_cndn_status.cndn_status_section.tbl_cndn_buyer_result_row}   ${element}

Verify filtered CN/DN results
    [Arguments]   ${filter}   ${value}

    ${filter}=    Run Keyword If    '${filter}' == 'CN/DN Number'    Set Variable    cndnNum
              ...   ELSE IF    '${filter}' == 'Invoice Number'    Set Variable    invoiceNum
              ...   ELSE IF    '${filter}' == 'Reference No.'    Set Variable    groupNum
              ...   ELSE IF    '${filter}' == 'Buyer'    Set Variable    buyerName
              ...   ELSE IF    '${filter}' == 'Supplier'    Set Variable    supplierName

    ${auth}=    Get Cookie    buyer_auth
    &{cookies}=    Create Dictionary    app_type=EInvoiceBuyer    buyer_auth=${auth.value}   buyer_lang=en
    ${api}=     Set Variable    api/groupCndnByApprover
    ${param}=    Set Variable    buyerMpID=${BUYERMPID}&userID=${TRUE_VERIFY_03}&${filter}=${value}&conditionValue=MyCondition&statusID=&fromDueDate=&toDueDate=&fromCreateDate=&toCreateDate=&page=0&size=20&sort=&defaultSort=createdDate,desc&taxInvoiceFilter=all&fromDate=&toDate=
   
    Create session    test    http://uat-invoice-portal.oneplanets.com    cookies=${cookies}
    ${response}=     Get Request    test    ${api}?${param}
    ${json}=   Convert String to JSON    ${response.text}
    #Get results
    ${results}=    Run Keyword If    '${filter}' == 'cndnNum'    Get Value From Json    ${json}     $.content[*].cndnNum
              ...   ELSE IF    '${filter}' == 'invoiceNum'    Get Value From Json    ${json}    $.content[*].cndnItems[*].invoiceNum
              ...   ELSE IF    '${filter}' == 'groupNum'    Get Value From Json    ${json}     $.content[*].groupNum
              ...   ELSE IF    '${filter}' == 'buyerName'    Get Value From Json    ${json}     $.content[*].buyerName
              ...   ELSE IF    '${filter}' == 'supplierName'    Get Value From Json    ${json}     $.content[*].supplierName
    #Validate results
    Run Keyword If    '${filter}' == 'cndnNum'    Should Contain Match    ${results}    ${value}
              ...   ELSE IF    '${filter}' == 'invoiceNum'    Should Contain    ${results}    ${value}
              ...   ELSE IF    '${filter}' == 'groupNum'    Should Contain    ${results}    ${value}
              ...   ELSE IF    '${filter}' == 'buyerName'    Should Contain Match    ${results}    ${value}*
              ...   ELSE IF    '${filter}' == 'supplierName'    Should Contain Match    ${results}    ${value}

Click calendar button
    Click Element       ${obj_cndn_status.cndn_calendar_menu.btn_calendar}  

Anytime radio button is selected
    Element Attribute Value Should Be    ${obj_cndn_status.cndn_calendar_menu.rdo_anytime}    checked    true

Click 'Any time' radio button
    Click Element       ${obj_cndn_status.cndn_calendar_menu.rdo_anytime} 

Click 'Received Date' radio button
    Click Element       ${obj_cndn_status.cndn_calendar_menu.rdo_date_range} 

Select from date   
    [Arguments]    ${cndn_from_date}
    #Convert Date Format
    ${cndn_from_date}=    Convert Date    ${cndn_from_date}    result_format=%Y-%m-%d
    #Get month and year
    ${month_txt}=    Convert Date    ${cndn_from_date}    result_format=%B
    ${year_txt}=    Convert Date    ${cndn_from_date}    result_format=%Y

    Click Element       ${obj_cndn_status.cndn_calendar_menu.txt_date_from}

    #Select Month
    :FOR    ${i}    IN RANGE    999999
    \    ${month_checker}=    Run Keyword And Return Status    Element Should Contain   ${obj_cndn_status.cndn_calendar_menu.spn_from_month_select}    ${month_txt}
    \    Exit For Loop If    ${month_checker} == True
    \    Wait Until Element Is Visible         ${obj_cndn_status.cndn_calendar_menu.btn_previous_from_month}    ${TIMEOUT}
    \    Click element     ${obj_cndn_status.cndn_calendar_menu.btn_previous_from_month}
    #Select Year
    :FOR    ${i}    IN RANGE    999999
    \    ${year_checker}=    Run Keyword And Return Status    Element Should Contain   ${obj_cndn_status.cndn_calendar_menu.spn_from_year_select}    ${year_txt}
    \    Exit For Loop If    ${year_checker} == True
    \    Wait Until Element Is Visible         ${obj_cndn_status.cndn_calendar_menu.btn_previous_from_year}    ${TIMEOUT}
    \    Click element     ${obj_cndn_status.cndn_calendar_menu.btn_previous_from_year}
    #Select Date
    Execute Javascript    document.getElementById('rb-buyer-calendar-dateFrom').querySelector("td[title='${cndn_from_date}'] > div").click()
    

Select to date    
    [Arguments]    ${cndn_to_date}
    #Convert Date Format
    ${cndn_to_date}=    Convert Date    ${cndn_to_date}    result_format=%Y-%m-%d
    #Get month and year
    ${month_txt}=    Convert Date    ${cndn_to_date}    result_format=%B
    ${year_txt}=    Convert Date    ${cndn_to_date}    result_format=%Y

    Click Element       ${obj_cndn_status.cndn_calendar_menu.txt_date_to}

    #Select Month
    :FOR    ${i}    IN RANGE    999999
    \    ${month_checker}=    Run Keyword And Return Status    Element Should Contain   ${obj_cndn_status.cndn_calendar_menu.spn_to_month_select}    ${month_txt}
    \    Exit For Loop If    ${month_checker} == True
    \    Wait Until Element Is Visible         ${obj_cndn_status.cndn_calendar_menu.btn_previous_to_month}    ${TIMEOUT}
    \    Click element     ${obj_cndn_status.cndn_calendar_menu.btn_previous_to_month}
    #Select Year
    :FOR    ${i}    IN RANGE    999999
    \    ${year_checker}=    Run Keyword And Return Status    Element Should Contain   ${obj_cndn_status.cndn_calendar_menu.spn_to_year_select}    ${year_txt}
    \    Exit For Loop If    ${year_checker} == True
    \    Wait Until Element Is Visible         ${obj_cndn_status.cndn_calendar_menu.btn_previous_to_year}    ${TIMEOUT}
    \    Click element     ${obj_cndn_status.cndn_calendar_menu.btn_previous_to_year}
    #Select Date
    Execute Javascript    document.getElementById('rb-buyer-calendar-dateTo').querySelector("td[title='${cndn_to_date}'] > div").click()

Verify Received Date of CN/DNs results    
    [Arguments]    ${cndn_from_date}    ${cndn_to_date}    ${cndn_status}
    #Convert Date Format
    ${cndn_from_date}=    Convert Date    ${cndn_from_date}    result_format=%Y-%m-%d
    ${cndn_to_date}=    Convert Date    ${cndn_to_date}    result_format=%Y-%m-%d
    #Set status value
    ${cndn_status}=    Run Keyword If    '${cndn_status}' == 'Awaiting'    Set Variable    1
              ...   ELSE IF    '${cndn_status}' == 'Approved'    Set Variable    3
              ...   ELSE IF    '${cndn_status}' == 'Rejected'    Set Variable    4
              ...   ELSE IF    '${cndn_status}' == 'Processing'    Set Variable    6
              ...   ELSE    Set Variable    ''

    ${auth}=    Get Cookie    buyer_auth
    &{cookies}=    Create Dictionary    app_type=EInvoiceBuyer    buyer_auth=${auth.value}   buyer_lang=en
    ${api}=     Set Variable    api/groupCndnByApprover
    ${param}=    Set Variable    buyerMpID=${BUYERMPID}&userID=${TRUE_VERIFY_03}&conditionValue=MyCondition&statusID=${cndn_status}&fromDueDate=&toDueDate=&fromCreateDate=&toCreateDate=&page=0&size=20&sort=&defaultSort=createdDate,desc&taxInvoiceFilter=all&fromDate=${cndn_from_date}&toDate=${cndn_to_date}
   
    Create session    test    http://uat-invoice-portal.oneplanets.com    cookies=${cookies}
    ${response}=     Get Request    test    ${api}?${param}
    ${json}=   Convert String to JSON    ${response.text}

    ${results}=    Get Value From Json    ${json}     $.content[*].receivedDate

    :FOR    ${element}    IN    @{results}
    \     ${element}=    Fetch From Left    ${element}    T
    \     ${element}=    Convert Date    ${element}    result_format=%Y-%m-%d
    #Validate date range
    \     Should be true    '${element}' >= '${cndn_from_date}'     
    \     Should be true    '${element}' <= '${cndn_to_date}'

Check date alert message
    Wait Until Element Is Visible    ${obj_cndn_status.cndn_calendar_menu.alert_invalid_date}    ${TIMEOUT}

'No results found' message is visible
    Wait Until Element Is Visible    ${obj_cndn_status.cndn_status_section.spn_no_results}    ${TIMEOUT}

Success bar for reject credit/debit note must be
    [Documentation]    Verify the reject success bar
    [Arguments]     ${expect_successbar}    ${cndn_number}
    
    ${reject_cndn_number}    Set Variable    ${cndn_number}
    Set Test Variable    ${reject_cndn_number}
    ${expect_successbar}    Replace Variables in YAML file  ${expect_successbar}
    
    Wait Until Element Is Visible    ${lbl_success_bar}    ${TIMEOUT}
    ${actual_successbar}    Get Text    ${lbl_success_bar}    
    Should Contain Any    ${expect_successbar}    ${actual_successbar}


Credit/Debit Note from search result must be
    [Documentation]    Verify search result
    [Arguments]    ${cndn_number}

    Search invoice with search keyword    ${cndn_number} 

Credit/Debit note status must be    
    [Arguments]    ${cndn_number_status}   

    Get Target CN/DN Status At Column "Status" At Row "1" And Set Variable 'original Status'
    Should Be Equal As Strings    ${cndn_number_status}    ${original_status}       