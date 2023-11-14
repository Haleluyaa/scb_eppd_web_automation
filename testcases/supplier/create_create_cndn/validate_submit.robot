*** Setting ***
### Global ###
Resource    ../../../resources/global_lib.resource
Resource    ../../../resources/global_var.resource
Resource    ../../../resources/global_keyword.resource
### Keyword for Common/Reuse ###
Resource    ../../../keywords/web/common/common_web_keywords.resource
Resource    ../../../keywords/api/common/common_api_keywords.resource
Resource    ../../../keywords/database/common/common_db_keywords.resource
Resource    ../../../keywords/web/common/invoice_menu_keywords.resource
### Page keyword releted ###
Resource    ../../../keywords/database/cndn/cndn_db_keywords.resource
Resource    ../../../keywords/web/invoice/invoice_status_keywords.resource
Resource    ../../../keywords/web/cn_dn/cndn_status_keywords.resource
Resource    ../../../keywords/web/cn_dn/view_cndn_keywords.resource
Resource    ../../../keywords/web/cn_dn/cndn_history_keywords.resource
Resource    ../../../keywords/database/cndn/view_history_db_keywords.resource
Resource    ../../../keywords/web/cn_dn/supplier_step1_keywords.resource


Suite Setup    Open setup browser with ${einvoice_url_web} and ${browser} and go to invoice supplier
Suite teardown    Clear all cookie and closed browser

Test setup    Go to cn/dn list page              

*** Test Cases ***
TC_eINVOICE_02329 : To verify Credit/ Debit Note Number and Credit/ Debit Note Date are required field for invoice online.
    [Tags]
    [Documentation]    verify message required field on field invoice numer and invoice date is required should be displayed
                ...    when not completed data to the fields.
    Given Go to invoice step1 for create credit note from ${buyer_cpall_company} and ${currency_code_thb}
    And Go to invoice step2 with first row of invoice step1
    When Click on text box invoice date on invoice row 1
    And Click on text box invoice number on invoice row 1
    And Press tab on text box invoice number on invoice row 1
    Then Required field message for invoice number should be ${required_message}
    And Required field message for invoice date should be ${required_message}

TC_eINVOICE_02330 : To verify the system should be disappear error message when completed data to Credit/Debit Note Number and Credit/Debit Note Date for invoice online.
    [Tags]
    [Documentation]    verify error message required field on invoice number and invoice date should be disappear
                ...    when completed data.    
    Given Go to invoice step1 for create credit note from ${buyer_cpall_company} and ${currency_code_thb}
    And Go to invoice step2 with first row of invoice step1
    When Click on text box invoice date on invoice row 1
    When Click on text box invoice number on invoice row 1
    And Press tab on text box invoice number on invoice row 1
    And Message error invoice number should be visible
    And Message error invoice date should be visible    
    And Input invoice number on invoice row 1 with CN-DN
    And Click on text box invoice date on invoice row 1
    And Choose invoice date on current date on invoice row 1
    Then Message error invoice number should not be visible 
    And Message error invoice date should not be visible     

TC_eINVOICE_02331 : To verify Tax Invoice Date and Vat Amount are required field when Tax Invoice Number not empty for invoice online.
    [Tags]
    [Documentation]    verify required fields on tax invoice date and vat amount should displayed when tax invoice number not empty value
    Given Go to invoice step1 for create credit note from ${buyer_cpall_company} and ${currency_code_thb}
    And Go to invoice step2 with first row of invoice step1
    And Input credit/debit note tax invoice number
    When Click submit button on invoice step2
    Then Required field message for tax invoice number should be ${required_message}
    And Required field message for tax invoice date should be ${required_message}

TC_eINVOICE_02332 : To verify Vat Base Amount is required field when Vat Amount not empty for invoice online.
    [Tags]
    [Documentation]

TC_eINVOICE_02333 : To verify the system should be disappear error message for Tax Invoice Date and Vat Amount when completed data on Tax Invoice Date and Vat Amount for invoice online.
    [Tags]
    [Documentation]

TC_eINVOICE_02334 : To verify the system should be disappear error message for VAT Base Amount when completed data in VAT Amount for invoice online.
    [Tags]
    [Documentation]

TC_eINVOICE_02335 : To verify cannot comppletely create invoice with required field error for invoice online.
    [Tags]
    [Documentation]

TC_eINVOICE_02336 : To verify error attachment icon for required attachment on invoice level for invoice online.
    [Tags]
    [Documentation]

TC_eINVOICE_02337 : To verify error attachment on upload modal for required attachment on invoice level for invoice online.
    [Tags]
    [Documentation]

TC_eINVOICE_02338 : To verify the system should be disappear error on invoice level when completely attache required attachment for invoice online.
    [Tags]
    [Documentation]

TC_eINVOICE_02339 : To verify error attachment icon for required attachment on invoice item level for invoice online.
    [Tags]
    [Documentation]

TC_eINVOICE_02340 : To verify error attachment on upload modal for required attachment on invoice item level for invoice online.
    [Tags]
    [Documentation]

TC_eINVOICE_02341 : To verify the system should be disappear error on invoice item level when completely attache required attachment for invoice online.
    [Tags]
    [Documentation]

TC_eINVOICE_02342 : To verify confirm create invoice message for invoice online.
    [Tags]
    [Documentation]

TC_eINVOICE_02343 : To verify cancel submit invoice for invoice online.
    [Tags]
    [Documentation]

TC_eINVOICE_02344 : To verify successfully submit invoice for invoice online.
    [Tags]
    [Documentation]










