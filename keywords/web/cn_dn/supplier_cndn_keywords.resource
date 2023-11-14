*** Settings ***
Variables    ../../../resources/locators/cn_dn/supplier_cndn_locators.yaml

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
Go to menu CN/DN
    Click on 'CN/DN' menu on left side
    Verify page 'CN/DN' display

#### 2020-09-29####

Supplier click 'Create CN/DN' button, then click option 'Select Invoice'
    Click 'Create CN/DN' button
    Click options in drop down list 'Select Invoice'     

Supplier go to menu CN/DN 
    supplier_cndn_keywords.Click on 'CN/DN' menu on left side
    supplier_cndn_keywords.Verify page 'CN/DN' display   

Supplier choose invoice type to 'Credit Note'
    Select invoice type for 'Credit Note'

Supplier choose create credit/debit note to buyer "${buyer}" and choose currency "${currency}"
    Choose buyer from drop down list    ${buyer}
    Choose currency from drop down list    ${currency}
    Click continue button

####       ####      ####    

User search CNDN "${CNDN_NUMBER_NEED_INFORMATION}" which has information icon 
    Click 'filter' dropdown list
    Click on target filter    ${TEXT.FILTER_CNDN_NUMBER}    
    input search keyword    ${CNDN_NUMBER_NEED_INFORMATION}
    Click search button

Cursor is hover at CNDN "${CNDN_NUMBER_NEED_INFORMATION}" information icon
    Move cursor to information icon    

User clicked at CNDN "${CNDN_NUMBER_NEED_INFORMATION}" information icon
    Click on information icon    

Hint tooltip is shown
    Verify tooltip visibility

Hint Modal is shown
    Verify Modal visibility

Modal shown correct data of CNDN "${CNDN_NUMBER_NEED_INFORMATION}" request
    Verify message from Buyer ​with DB    ${CNDN_NUMBER_NEED_INFORMATION}
    Verify Buyer name ​with DB    ${CNDN_NUMBER_NEED_INFORMATION}
    Verify date and time of Request ​with DB    ${CNDN_NUMBER_NEED_INFORMATION}

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
Click 'Create CN/DN' button

    [Documentation]    User click button 'Create CN/DN'
    Wait until loading complete
    Wait Until Element Is Visible    ${btn_create['btn_create_cndn']}    ${TIMEOUT}
    Click Element    ${btn_create['btn_create_cndn']}

Click options in drop down list 'Select Invoice' 
    [Documentation]    User select option 'Select Invoice' from action 'Create CN/DN'

    Wait Until Element Is Visible    ${btn_create['btn_options_select_invoice']}    ${TIMEOUT}
    Click Element    ${btn_create['btn_options_select_invoice']}

Select invoice type for 'Credit Note'
    [Documentation]    Supplier choose invoice type Credit Note 

    Modal create 'CN/DN' is displayed
    Click Element    ${modal_create_cndn['rdo_invoice_type']['credit_note']}

Select invoice type for 'Debit Note'
    [Documentation]    Supplier choose invoice type Credit Note 

    Modal create 'CN/DN' is displayed
    Click Element    ${modal_create_cndn['rdo_invoice_type']['dedit_note']}    

Modal create 'CN/DN' is displayed
    [Documentation]    Verify modal for select buyer and currency be displayed
    Wait Until Element Is Visible    ${modal_create_cndn['modal']}    ${TIMEOUT}

Choose buyer from drop down list
    [Arguments]    ${buyer_name}
    [Documentation]    choose buyer from dropdown list by buyer name

    Wait until element is visible    ${modal_create_cndn['ddl_buyer']['ddl_selected_buyer_cndn_locator']}
    Click element    ${modal_create_cndn['ddl_buyer']['ddl_selected_buyer_cndn_locator']}
    ${buyer_locator}    Replace Variables    ${modal_create_cndn['ddl_buyer']['list_select_buyer_cndn_locator']}
    
    Click element    ${buyer_locator}

Choose currency from drop down list
    [Arguments]    ${currency}   
    [Documentation]    choose currecy from drop  down list by currency code

    Wait until element is visible    ${modal_create_cndn['ddl_currency']['ddl_currency_cndn_locator']}
    Click element    ${modal_create_cndn['ddl_currency']['ddl_currency_cndn_locator']}
    ${currency_locator}    Replace Variables    ${modal_create_cndn['ddl_currency']['list_currency_cndn_locator']}

    Click element    ${currency_locator} 

Click continue button
    [Documentation]    Click continue button on modal 'Create CN/DN'

    Wait Until Element Is Visible    ${modal_create_cndn['btn_continue']}     ${TIMEOUT}
    Click Button    ${modal_create_cndn['btn_continue']}

Verify page 'CN/DN' display
    Wait Until Element Is Visible    ${btn_create['btn_create_cndn']}    ${TIMEOUT}

Click on 'CN/DN' menu on left side
    Wait until loading complete
    sleep    1s
    Wait Until Element Is Visible   ${obj_cndn_status.right_menu.lnk_cndn_menu}     ${TIMEOUT}
    Wait until loading complete
    Click Element    ${obj_cndn_status.right_menu.lnk_cndn_menu}
    Wait until loading complete

Click 'filter' dropdown list
    Wait Until Element Is Visible    ${obj_cndn_status.cndn_search_filter_section.ddl_cndn_filter}   ${TIMEOUT} 
    Click Element    ${obj_cndn_status.cndn_search_filter_section.ddl_cndn_filter}

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

Click on information icon 
    Wait Until Element Is Visible    ${obj_cndn_tooltip.btn_tooltip}    ${TIMEOUT}
    Click Element    ${obj_cndn_tooltip.btn_tooltip}

Move cursor to information icon    
    Mouse Over    ${obj_cndn_tooltip.btn_tooltip}

Verify tooltip visibility
    Wait Until Element Is Visible    ${obj_cndn_tooltip.spn_tooltip}   ${TIMEOUT}

Verify Modal visibility
    Wait Until Element Is Visible    ${obj_request_modal.mdl_request_document}    ${TIMEOUT}

Verify message from Buyer ​with DB
    [Arguments]    ${CNDN_NUMBER_NEED_INFORMATION}
    ${request_document_message_db}=    eInvoice Execute SELECT query string    SELECT NoteToSupplier FROM CNDN WHERE CNDNNum = '${CNDN_NUMBER_NEED_INFORMATION}'
    ${request_document_message_web}=     Get Text   ${obj_request_modal.lbl_request_document_message}
    Should be equal    ${request_document_message_db}[0][0]   ${request_document_message_web}

Verify Buyer name ​with DB 
    [Arguments]    ${CNDN_NUMBER_NEED_INFORMATION}
    ${buyer_username}=    eInvoice Execute SELECT query string    SELECT UpdatedBy FROM CNDN WHERE CNDNNum = '${CNDN_NUMBER_NEED_INFORMATION}'
    ${request_document_buyer_db}=    RBAC Execute SELECT query string    SELECT firstName FROM users WHERE username = '${buyer_username}[0][0]'
    ${request_document_buyer_web}=     Get Text   ${obj_request_modal.spn_request_document_buyer}
    Should be equal    ${request_document_buyer_db}[0][0]   ${request_document_buyer_web}

Verify date and time of Request ​with DB
    [Arguments]    ${CNDN_NUMBER_NEED_INFORMATION}
    ${request_datetime_db}=    eInvoice Execute SELECT query string    SELECT FORMAT([UpdatedDate],'yyyy-MM-dd hh:mm:ss.fff') FROM CNDN WHERE CNDNNum = '${CNDN_NUMBER_NEED_INFORMATION}'
    ${request_datetime_db}=    convert date    ${request_datetime_db}[0][0]
    ${request_datetime_db}=    add time to date    ${request_datetime_db}    7 hours
    ${request_datetime_db}=    convert date    ${request_datetime_db}    result_format=%d/%m/%Y %H:%M
    ${request_date_db}=    Fetch from left    ${request_datetime_db}    ${SPACE}
    ${request_time_db}=    Fetch from right    ${request_datetime_db}    ${SPACE}
    ${request_datetime_web}=    Get Text   ${obj_request_modal.spn_request_document_datetime}
    ${request_date_web}=    Fetch from left    ${request_datetime_web}    ${SPACE}
    ${request_time_web}=    Fetch from right    ${request_datetime_web}    ${SPACE}
    Should be equal   ${request_date_db}   ${request_date_web}
    Should be equal   ${request_time_db}   ${request_time_web}