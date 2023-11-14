*** Settings ***
Variables    ../../../resources/locators/cn_dn/closed_creditdebit_note_locators.yaml

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

Click menu Close CN/DN on "${CNDN_NUM}"    ### Move to list page
    [Documentation]    Click menu Close CN/DN at Approval List on specific CN/DN Number

    cndn_approve_keywords.Search CN/DN with search keyword    ${CNDNNum} 
    Click action Close CN/DN at specifice credit/debit note number    ${CNDNNum}   

Go to view credit/debit on specific "${cndn_num}" from column "${column_name}"     #>>> Move to list page
    [Documentation]    Go to view credit/debit note page by click on credit/debit note row
                ...    on approval list

    Go to "View CNDN Detail" on specific invoice number "${cndn_num}" on column "${column_name}" 

Input data into default field Date next day and Payment Location "${select_payment_locator}" and Note "${note_to_supplier}"
    [Documentation]    Input data into default field
                ...    Within Date with ${WITHIN}
                ...    Payment Location with ${PAYMENT_LOCATION}
                ...    Note with ${NOTE}

    Input data into date calendar next day 
    Select payment location option    ${select_payment_locator}  
    Input note into note textarea    ${note_to_supplier}         


Input data into default field current date and Payment Location "${select_payment_locator}" and Note "${note_to_supplier}"
    [Documentation]    Input data into default field
                ...    Within Date with ${WITHIN}
                ...    Payment Location with ${PAYMENT_LOCATION}
                ...    Note with ${NOTE}

    Select closed cndn due date to current date 
    Select payment location option    ${select_payment_locator}  
    Input note into note textarea    ${note_to_supplier}  

Input data in to configuration field with text "${config_data}" and select next day and first value in dropdown list
    [Documentation]    Input data into configuration field
                ...    Text Form input "123456789"
                ...    Date choose next date
                ...    Dropdown list choose first value

    Get configuration field type , input data and set to list   ${config_data}
  

Confirm Close CN/DN
    [Documentation]    Click Close CN/DN button

    Click Close CN/DN button    

Verify Close CN/DN data in database correctly at CN/DN Number "${cndn_number}" and user "${user_id}"
    [Documentation]    Verify data that save into database

    Reload page
    Verify current approver in database at CN/DN Number    ${cndn_number}   
    Verify next approver in database at CN/DN Number    ${cndn_number}   
    Verify cn/dn status at CN/DN Number    ${cndn_number}   
    Verify buyer reference number at Group Level and CN/DN level on CN/DN Number    ${cndn_number}    
    Verify CN/DN Number History at CN/DN Number    ${cndn_number}   ${user_id}
    

Verify Close CN/DN at View CN/DN detail correctly at CN/DN Number "${cndn_number}" on Payment Location "${select_payment_location}"
    [Documentation]    Verify Close CN/DN data at View CN/DN Detail page

    approval_view_cndn_keywords.Go to 'View CN/DN detail page' of CN/DN Number "${cndn_number}"
    Verify due date is correctly and payment location    ${select_payment_location}  
    # Verify SAP Detail    

Verify configuration Close CN/DN required fields show error "${ERROR_REQUIRED_FIELD}"
    [Documentation]    Verify required field, compare screen and database
    ${db_required_field}    Get configuration required field Close CN/DN from db 
    Clear Value from UI     ${db_required_field}
    Compare Close CN/DN configuration required field    ${db_required_field}    ${ERROR_REQUIRED_FIELD}

Verify arrangement for configuration Close CN/DN correct
    [Documentation]    Verify element arrangement for default element
        
    ${db_arrangement_field}    Get configuration arrangement field Close CN/DN from db 
    Compare Close CN/DN configuration arrangement field    ${db_arrangement_field}    

Verify configuration Close CN/DN dropdown list value    
    ${db_dropdown_field}    Get configuration dropdown field Close CN/DN value first field from db 
    Compare Close CN/DN configuration dropdown value field    ${db_dropdown_field}    


Verify default required field on duedate "${error_message}"
    [Documentation]    Verify required field message that display on the screen
                ...    error message arguments as list-like

    Get and verify required field message on due date    ${error_message}


Verify default required field payment location "${error_message}"    
    [Documentation]    Verify required field message that display on the screen
                ...    error message arguments as list-like

    Get and verify required field message on payment location    ${error_message}

#Click button Close CN/DN on View Credit/Debit Note  
#    [Documentation]    Click button "Close CN/DN" at top right corner 
#                ...    on the View Credit/Debit Note page
#
#    Click button Close CN/DN at view CN/DN detail

Verify arrangement default field on the modal
    [Documentation]    Verify the arrangement close creditdebit note default fields
                ...    Verify by compare vertical position from Top to Buttom

    ${field_default_postition}    Get default element filed position
    Compararison default field position in vertical    ${field_default_postition} 

Input data "${within_date}" into within date
    [Documentation]    Input within date into textbox

    Input data into within date textbox  ${within_date}

Verify within date accept only number and 3 digits of number
    [Documentation]    Verify the within date in the text box
                ...    That accept only three digits of number

    ${within}    Get within date from textbox
    Verify within date data    ${within} 

Click on dropdown list payment location
    [Documentation]    Click textbox payment location

    Click payment location dropdown list

Verify payment location same with database  
    [Documentation]    Comparison payment location between Database and UI
                ...    Comparison in list-like format

    Verify payment location options  

Closed modal "Close Credit/Debit Note"
    [Documentation]    Closed the Modal Close CN/DN

    Click "X" at top right corner of modal "Close CN/DN"
    
        

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

Input data into within date textbox    
    [Arguments]    ${within_date_data}
    [Documentation]    Input Due Date : Within into textbox

    Wait Until Element Is Visible    ${duedate.rdo_within_date}    ${TIMEOUT}   
    Select Radio Button    ${duedate.rdo_group}    ${duedate.rdo_within_date_value}
    Clear Element Text    ${duedate.txt_within_date}
    Input Text    ${duedate.txt_within_date}    ${within_date_data}

Input data into date calendar next day 
    [Documentation]    Select next date from calendar
                ...    Next date is next date from default value in calendar

    ${input_due_date}=    Get Current Date    increment= 1d    result_format=%Y-%#m-%#d
    ${string_input_due_date_wo_zeropad}       Convert To String   ${input_due_date}    
    ${string_input_due_date_wo_zeropad}=     Replace string      ${string_input_due_date_wo_zeropad}      -0      -
    #Select Date
    Wait Until Element Is Visible    ${duedate.calendar}    ${TIMEOUT}
    Click Element    ${duedate.calendar}
    Execute Javascript    document.querySelector("td[title='${string_input_due_date_wo_zeropad}'] > div").click()

Select closed cndn due date to current date
    Wait Until Element Is Visible    //input[@id="open-calendar"]    ${TIMEOUT}
    Click Element    //input[@id="open-calendar"]
    Click Element    //div[@class="rc-calendar-date"][@aria-selected="true"]


Select payment location option    
    [Arguments]    ${payment_location_data}
    [Documentation]    Select payment location from dropdown list
    #replace location with selected option

    #${payment_option}    Replace String    ${payment_location.option_select}    REPLACE_ME    ${payment_location_data}
    ${payment_option}    Replace Variables    ${payment_location.option_select}    #REPLACE_ME    ${payment_location_data}

    Click Element    ${payment_location.txt_payment_location}
    Wait Until Element Is Visible   ${payment_location.option_first}    ${TIMEOUT}
    Click Element    ${payment_option} 

Click payment location dropdown list
    [Documentation]    Click textbox payment location

    Wait Until Element Is Visible    ${payment_location.txt_payment_location}    ${TIMEOUT}
    Click Element    ${payment_location.txt_payment_location}

Input note into note textarea    
    [Arguments]  ${note_data}
    [Documentation]    Input note into note text area

    Wait Until Element Is Visible    ${txtarea_note_approve}    ${TIMEOUT}
    Input Text    ${txtarea_note_approve}    ${note_data}

Input data into configuration text form    
    [Arguments]    ${config_data}   ${locator}
    [Documentation]    Input data into text form at configuration element
    
    Wait Until Element Is Visible    ${locator}    ${TIMEOUT}
    ${lbl_locator}=     Get Element Attribute   ${locator}  placeholder
    Run Keyword if          '${lbl_locator}' == '${lbl_FIYEAR}'     Input Text    ${locator}    ${FISCAL_YEAR}
    ...     ELSE IF         '${lbl_locator}' == '${lbl_FIDOC}'      Input Text    ${locator}    ${FIDOC} 
    ...     ELSE                                                    Input Text    ${locator}    ${config_data} 

    # ${str_id}=    Get "input_id" from element     ${locator}
    # Create dictionary and append data to 'Config fields data list'  ${str_id}   ${config_data}

Select configuration date to next date from calendar
    [Arguments]    ${locator}
    [Documentation]    Select next date from calendar
                ...    Next date is next date from default value in calendar

    ${closed_date}=    Get Current Date    increment= 1d    result_format=%Y-%#m-%#d
    ${string_closed_date_wo_zeropad}       Convert To String   ${closed_date}    
    ${string_closed_date_wo_zeropad}=     Replace string      ${string_closed_date_wo_zeropad}      -0      -
    #Select Date
    Wait Until Element Is Visible    ${locator}    ${TIMEOUT}
    Click Element    ${locator}
    Execute Javascript    document.getElementById('rb_calendarPopup_ui').querySelector("td[title='${string_closed_date_wo_zeropad}'] > div").click()

Select configuration date to current date from calendar
    [Arguments]    ${locator}
    [Documentation]    Select current date from calendar
                ...    Next date is next date from default value in calendar

    Wait Until Element Is Visible    ${locator}    ${TIMEOUT}
    Click Element    ${locator}
    Click Element    //div[@class="rc-calendar-date"][@aria-selected="true"]

Choose configuration dropdown list at first value
    [Arguments]    ${locator}
    [Documentation]    Choose at first value from configuration dropdown list 

    Wait Until Element Is Visible    ${locator}    ${TIMEOUT}
    Click Element    ${locator}
    Wait Until Element Is Visible    ${locator}/option[2]    ${TIMEOUT}
    Click Element    ${locator}/option[2]
    ${selected_value}=  Get Element Attribute   ${locator}/option[2]    value

    # ${str_id}=    Get "input_id" from element     ${locator}
    # Create dictionary and append data to 'Config fields data list'  ${str_id}   ${selected_value}

Click Close CN/DN button 
    [Documentation]    Confirm close cn/dn on modal

    Wait Until Element Is Visible    ${btn.close_cndn}    ${TIMEOUT}
    Click Element    ${btn.close_cndn}

Verify current approver in database at CN/DN Number    
    [Arguments]    ${CNDN_NUM}
    [Documentation]    Verify the current data that correct in database
    ${cndn_id}=    eInvoice Execute SELECT query string     SELECT CNDNID FROM CNDN WHERE CNDNNum = '${CNDN_NUM}'
    ${cndn_id}=    Set Variable   ${cndn_id}[0][0]
    ${current_approval}=     eInvoice Execute SELECT query string    SELECT lower(Approver) as Approver FROM CNDNApproval WHERE CNDNID = '${cndn_id}'
    ${current_approval}=    Set Variable   ${current_approval}[0][0]
    Should be Equal     ${current_approval}    ${TRUE_APP_TYPE_1}

Verify next approver in database at CN/DN Number    
    [Arguments]    ${CNDN_NUM}
    [Documentation]    Verify the current data that correct in database incase no next approver skip check (count record <= 1)

    ${cndn_id}=    eInvoice Execute SELECT query string     SELECT CNDNID FROM CNDN WHERE CNDNNum = '${CNDN_NUM}'
    ${cndn_id}=    Set Variable   ${cndn_id}[0][0]
    ${next_approval}=     eInvoice Execute SELECT query string    SELECT Approver FROM CNDNApproval WHERE CNDNID = '${cndn_id}'
    ${FoundNextApproval}=   Get Length   ${next_approval}
    run Keyword if          ${FoundNextApproval} > 1    Should be Equal     ${next_approval}[1][0]    ${NONE}
    

Verify cn/dn status at CN/DN Number    
    [Arguments]    ${CNDN_NUM}
    [Documentation]    Verify the CN/DN status

    ${cndn_id}=    eInvoice Execute SELECT query string     SELECT CNDNID FROM CNDN WHERE CNDNNum = '${CNDN_NUM}'
    ${cndn_id}=    Set Variable   ${cndn_id}[0][0]
    ${cndn_status}=     eInvoice Execute SELECT query string    SELECT ApprovalStatusID FROM CNDNApproval WHERE CNDNID = '${cndn_id}'
    ${cndn_status}=    Set Variable   ${cndn_status}[0][0]
    Should be Equal as integers     ${cndn_status}   6

Verify buyer reference number at Group Level and CN/DN level on CN/DN Number    
    [Arguments]    ${CNDN_NUM}
    [Documentation]    Verify the reference number at Group Level and CN/DN Level check row and column not null 
    ${Group_id}=    eInvoice Execute SELECT query string     SELECT GroupID FROM CNDN WHERE CNDNNum = '${CNDN_NUM}'
    ${Group_id}=    Set Variable   ${Group_id}[0][0]
    ${ReferenceNumber}=     eInvoice Execute SELECT query string    SELECT GroupNumBuyer FROM GroupCNDN WHERE GROUPID = '${Group_id}'
    ${ReferenceNumber}=    Set Variable   ${ReferenceNumber}[0][0]
    Should Not Be Equal     ${ReferenceNumber}    ${None}

Verify CN/DN Number History at CN/DN Number    
    [Arguments]    ${CNDN_NUM}     ${user_id}
    [Documentation]    Verify Close CN/DN History   

    ${cndn_id}=    eInvoice Execute SELECT query string     SELECT CNDNID FROM CNDN WHERE CNDNNum = '${CNDN_NUM}'
    ${cndn_id}=    Set Variable   ${cndn_id}[0][0]
    ${cndn_history}=     eInvoice Execute SELECT query string    SELECT lower(ActionBy) as ActionBy, Activity, Category FROM CNDNHistory WHERE CNDNID = '${cndn_id}' ORDER BY LogDate DESC
    ${action_by}=    Set Variable   ${cndn_history}[0][0]
    ${activity}=    Set Variable   ${cndn_history}[0][1]
    ${category}=    Set Variable   ${cndn_history}[0][2]
    Should be Equal     ${action_by}    ${user_id}
    Should be Equal     ${activity}    The Credit/Debit Note has finished all the approval steps. (Close Manual)
    Should be Equal     ${category}    CloseCNDN

Verify due date is correctly and payment location    
    [Arguments]    ${PAYMENT__LOCATION}
    [Documentation]    Verify the payment location at View CN/DN page
    #${due__date}=    Get Current Date    increment= 1d    result_format=%d/%m/%Y
    ${due__date}=    Get Current Date    result_format=%d/%m/%Y
    Verify due date and Payment location display correctly   ${due__date}   ${PAYMENT__LOCATION}
    
Verify SAP Detail    #No >>    
    [Documentation]    Verify the SAP Detail if its' display on the screen


Get configuration required field Close CN/DN from db 
    [Documentation]    Get required field from DB
                ...    BuyerMpId can send from parameter ot get from header 
    ${sql_cndn_UIItemClose}=     Get query string for SELECT 'CNDN_UIItemClose' where with 'IsRequired'
    ${return_cndn_UIItemClose}=  eInvoice Execute SELECT query string    ${sql_cndn_UIItemClose}
    [Return]    ${return_cndn_UIItemClose}    

Compare Close CN/DN configuration required field
    [Arguments]    ${db_required_field}    ${error_msg}
    [Documentation]    Compare required field from DB and UI 
    ${rowCount}     Get Length   ${db_required_field}
    :FOR     ${i}    IN RANGE    0    ${rowCount}
    \   ${lbl_configuration_fields}=    set variable    ${db_required_field[${i}][0]}
    \   ${lbl_config_locator}   Replace variables   ${msg_required.config}
    \   Element should be visible       ${lbl_config_locator} 

Clear Value from UI
    [Arguments]    ${db_required_field}
    ${rowCount}     Get Length   ${db_required_field}
    :FOR     ${i}    IN RANGE    0    ${rowCount}
    \   ${UI_locator}=    Get Locator for configuration required field      ${db_required_field[${i}][1]}
    \   ${lbl_config}=      Set variable        ${db_required_field[${i}][0]}
    \   ${lbl_config_locator}   Replace variables   ${config.txt_with_value}
    \   Run Keyword If      '${db_required_field[${i}][1]}' != 'dropdown'      Clear Element Text      ${lbl_config_locator}

Get Locator for configuration required field
    [Arguments]     ${UI_type}
    ${UI_type_locator} =	Run Keyword If	'${UI_type}' == 'date'	Set variable    /following-sibling::div/input
    ...	ELSE IF     '${UI_type}' == 'dropdown'                      Set variable    /following-sibling::select
    ...	ELSE                                                        Set variable    /following-sibling::input
    [Return]    ${UI_type_locator}

Get configuration arrangement field Close CN/DN from db 
    [Documentation]    Get arrangement field from DB
    ${sql_cndn_UIItemClose}=     Get query string for SELECT 'CNDN_UIItemClose'
    ${return_cndn_UIItemClose}=  eInvoice Execute SELECT query string    ${sql_cndn_UIItemClose}
    [Return]    ${return_cndn_UIItemClose}     

Compare Close CN/DN configuration arrangement field
    [Arguments]    ${db_arrangement_field}      
    [Documentation]    Compare arrangement field from DB and UI 
     ${rowCount}     Get Length   ${db_arrangement_field}
    :FOR     ${i}    IN RANGE    0    ${rowCount}
    \   ${row_ui}=  evaluate    ${i}+1
    \   ${lbl_config}=      Set variable        ${db_arrangement_field[${i}][0]}
    \   ${ui_config_locator}   replace variables    ${config.lbl}
    \   Element Should be visible   ${ui_config_locator}


Get configuration dropdown field Close CN/DN value first field from db 
    [Documentation]    Get dropdown value from DB
    ${sql_cndn_UIItemClose}=     Get query string for SELECT 'CNDN_UIItemLookup'
    ${return_cndn_UIItemClose}=  eInvoice Execute SELECT query string    ${sql_cndn_UIItemClose}
    [Return]    ${return_cndn_UIItemClose} 

Compare Close CN/DN configuration dropdown value field    
    [Arguments]  ${db_ddl_field}   
    [Documentation]    Compare dropdown option from DB and UI
     ${rowCount}     Get Length   ${db_ddl_field}
     ${row_seq}=    set variable    ${db_ddl_field[0][0]}
     ${ddl_count_locator}   replace variables   ${config.ddl_with_value}
     ${option_count}    Get Element Count   ${ddl_count_locator}
    :FOR     ${i}    IN RANGE    0    ${rowCount}
    \   ${ddl_value_locator}   replace variables    ${config.ddl}
    \   Click Element       ${ddl_value_locator}
    \   Select From List By Label   ${ddl_value_locator}    ${db_ddl_field[${i}][1]}
    Should be equal as integers       ${option_count}     ${rowCount}

Get and verify required field message on due date
    [Arguments]    ${expected_required_msg}
    [Documentation]    Verify the required message for due date on ui
                ...    Arguments is list-like variable

    Wait Until Element Is Visible    ${msg_required.duedate}    ${TIMEOUT}
    ${actual_required_msg}    Get Text    ${msg_required.duedate}

    Should Contain    ${expected_required_msg}    ${actual_required_msg}

Get and verify required field message on payment location
    [Arguments]    ${expected_required_msg}
    [Documentation]    Verify the required message for payment location
                ...    Arguments is list-like variable

    Wait Until Element Is Visible    ${msg_required.payment_location}    ${TIMEOUT}
    ${actual_required_msg}    Get Text    ${msg_required.payment_location}

    Should Contain    ${expected_required_msg}    ${actual_required_msg}      

Get sequence element in Close CN/DN modal
    [Documentation]    Get element for compare element arrangement in the screen  

Get Due Date Position
    [Documentation]    Get Vertical Position of Due Date element

    Wait Until Element Is Visible    ${duedate.calendar}    ${TIMEOUT}
    ${duedate_position}    Get Vertical Position    ${duedate.calendar}

    [Return]    ${duedate_position}    

Get Payment Location Position  
    [Documentation]    Get Veriticaal Position of Payment Location  

    Wait Until Element Is Visible    ${payment_location.txt_payment_location}    ${TIMEOUT}
    ${payment_location_position}    Get Vertical Position    ${payment_location.txt_payment_location}

    [Return]    ${payment_location_position}  

Get Note Position    
    [Documentation]    Get Veritical Postition of Note    

    Wait Until Element Is Visible    ${txtarea_note_approve}    ${TIMEOUT}
    ${note_position}    Get Vertical Position    ${txtarea_note_approve}
    
    [Return]    ${note_position}   

Get default element filed position   
    [Documentation]    Get element vertical position then
                ...    append data into list-like and return from variable 

    ${duedate_position}    Get Due Date Position
    ${payment_location_position}    Get Payment Location Position
    ${note_position}    Get Note Position

    @{default_position}    Create List    ${duedate_position}    ${payment_location_position}       ${note_position}

    [Return]    ${default_position}      

Compararison default field position in vertical
    [Arguments]    ${list_position}
    [Documentation]    Comparison arrange default fields in close credit/debit note
                ...    Verify by compare vetical position from Top to Button
                ...    In sequence Due Date, Payment Location and Note

    ${initial}    Set Variable    0

    :FOR    ${item}    IN    @{list_position}
        Should Be True    ${item}>${initial}
        ${initial}    Set Variable    ${item}
    END

Get within date from textbox
    [Documentation]    Get within date value from the text box

    Wait Until Element Is Visible    ${duedate.txt_within_date}    ${TIMEOUT}
    ${within}    Get Value    ${duedate.txt_within_date}

    [Return]    ${within}

Verify within date data   
    [Arguments]    ${within}
    [Documentation]    Verify the value in within date textbox
    
    ${len}    Get Length    ${within}
    Should Be Equal As Numbers    ${within}    ${within}
    Length Should Be    ${within}    3

Verify payment location options
    [Documentation]    Comparison the payment location options
                ...    Comparison by the data in Database and UI
                ...    Comparison by list-like variable

    ${payment_location_ui}    Get payment location UI
    ${payment_location_db}    Get payment location true from DB
    Verify payment location should be equal    ${payment_location_db}    ${payment_location_ui}


Get payment location UI
    [Documentation]    Verify Payment Location Options on modal Close CN/DN
                ...    Verify by comparison between UI and Database 
  
    @{payment_locator}    Create List
    Wait Until Element Is Visible    ${payment_location.txt_payment_location}    ${TIMEOUT}
    ${cnt}    Get Element Count    ${payment_location.txt_payment_location}/option
    ${cnt}    Evaluate    ${cnt}+1
    :FOR    ${index}    IN RANGE    2    ${cnt}
        ${location}    Get Text    (${payment_location.txt_payment_location}/option)[${index}]
        Append To List    ${payment_locator}    ${location}
    END

    [Return]    ${payment_locator}

Get payment location true from DB   
    [Documentation]    Get payment location of EP True from database
    
    @{list_db}    Create List
  
    ${payment_location_query}    Select query get true payment location
    ${payment_locator_db}    eInvoice Execute SELECT query string    ${payment_location_query}

    ${list_len}    Get Length    ${payment_locator_db}
    FOR   ${seq}    IN RANGE    0    ${list_len}

        Append To List    ${list_db}    ${payment_locator_db}[${seq}][0]

    END    

    [Return]    ${list_db}

Verify payment location should be equal    
    [Arguments]    ${db_list}    ${ui_list}
    [Documentation]    Comparison two list-like

    Lists Should Be Equal    ${db_list}    ${ui_list}

Click "X" at top right corner of modal "Close CN/DN"   
    [Documentation]    Click 'X' on closed credit/debit note modal
    #debug
    Scroll Element Into View     ${close_cndn_modal_title}
    Wait Until Element IS Visible     ${ico_x_closed_modal}    ${TIMEOUT}
    Click Element     ${ico_x_closed_modal}

Get configuration field type , input data and set to list 
    [Arguments]    ${config_data}
    @{Config_fields_input_data}    Create List
    Set test variable   ${Config_fields_input_data}     ${Config_fields_input_data}
    ${Config_field_count}=  Get Element Count       //div/li
    FOR   ${seq}    IN RANGE    1    ${Config_field_count+1}

        ${locator_check_txt}    Replace variables    ${check_config_txt}
        ${locator_check_date}   Replace variables    ${check_config_date}
        ${locator_check_ddl}    Replace variables    ${check_config_ddl}
        ${txt_checker}     Run Keyword And Return Status   Page Should Contain Element     ${locator_check_txt}
        ${date_checker}     Run Keyword And Return Status   Page Should Contain Element     ${locator_check_date}
        ${ddl_checker}     Run Keyword And Return Status   Page Should Contain Element     ${locator_check_ddl}
        Run Keyword If      '${txt_checker}' == 'True'           Input data into configuration text form    ${config_data}   ${locator_check_txt}
                #...   ELSE IF    '${date_checker}' == 'True'     Select configuration date to next date from calendar   ${locator_check_date}
                ...    ELSE IF    '${date_checker}' == 'True'     Select configuration date to current date from calendar   ${locator_check_date}
                ...    ELSE IF    '${ddl_checker}' == 'True'      Choose configuration dropdown list at first value      ${locator_check_ddl}

    END  






Create dictionary and append data to 'Config fields data list'
    [Arguments]    ${input_id}  ${data}
     ${dictionary_input_data}=    Create Dictionary    InputID=${input_id}    data=${data}
     Append To List    ${Config_fields_input_data}    ${dictionary_input_data}

Get "input_id" from element
    [Arguments]    ${locator}
    ${id_value}=    Get Element Attribute   ${locator}  id
    ${id}=      Replace String      ${id_value}     input_      ${EMPTY}	
    ${id}=      Replace String      ${id}     calendar-      ${EMPTY}	
    [Return]    ${id}