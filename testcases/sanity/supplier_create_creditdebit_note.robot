*** Setting ***
### Global ###
Resource    ../../resources/global_lib.resource
Resource    ../../resources/global_var.resource
Resource    ../../resources/global_keyword.resource
### Keyword for Common/Reuse ###
Resource    ../../keywords/web/common/common_web_keywords.resource
Resource    ../../keywords/web/common/invoice_menu_keywords.resource
Resource    ../../keywords/web/thirdparty/common_ep_login_keywords.resource
Resource    ../../keywords/web/common/invoice_menu_keywords.resource
### Page keyword releted ###
Resource    ../../keywords/web/cn_dn/supplier_cndn_keywords.resource
Resource    ../../keywords/web/cn_dn/supplier_step1_keywords.resource
Resource    ../../keywords/web/cn_dn/supplier_step2_keywords.resource

### Test Suite Data ###
Variables   ../../resources/testdata/${env}/invoice/create_invoice.yaml
Variables   ../../resources/testdata/${env}/invoice/invoice_status.yaml
Variables   ../../resources/testdata/${env}/sanity.yaml

Suite Setup    Go to einvoice website via SWW with "${SWW_USER}" and "${SWW_PASS}"
Suite Teardown     Run Keywords    Delete All Cookies
                            ...    Close browser
Test Teardown   Reload page

***Variables***
${CREATE_CNDN_BUYER}    True Move H Universal CommunicationCo., Ltd. (Head Office)
${CREATE_CNDN_CURRENCY}    THB


***Test Cases***
To verify create 'Credit/Debit Note' and adjust amount
    [Tags]    Sanity    Ready    Supplier   CreateCNDN    SupplierCreateCNDN
    [Documentation]    Sanity for testcases create 'Credit/Debit Note' from supplier

    Given Supplier go to menu CN/DN
    When Supplier click 'Create CN/DN' button, then click option 'Select Invoice'
    And Supplier choose invoice type to 'Credit Note'
    And Supplier choose create credit/debit note to buyer "${CREATE_CNDN_BUYER}" and choose currency "${CREATE_CNDN_CURRENCY}"
    Comment    Phase for verify search
    When Supplier search invoice via "Invoice Number" and "Invoice Created" via data in row "1"
    Then Search result data in column "Invoice Number" and "Invoice Created" same criteria
    
    Comment    Phase for verify delete invoice from step2
    And Supplier add 2 invoice then click invoice to go to create 'Credit/Debit Note' step2
    When Supplier delete invoice item row "1"
    Then Invoice item should deleted and invoice item row 2 change to row 1
    And Back to created 'Credit/Debit Note' step1 when deleted all group credit/debit not in create 'Credit/Debit Note' step2
    
    Comment    Phase for submit invoice with validation
    And Supplier add 1 invoice to credit/debit note then click invoice to go to create 'Credit/Debit Note' step2
    When Supplier click 'Submit' button
    Then Error should be show at credit/debit note number and date
    And Error should be show at invoice 'Credit/Debut Note Date' and VAT when input only 'Creaid/Debit Note Tax' 
    And Error should be shown at 'VAT Base Amount' when input input 'VAT' without 'VAT Base Amount'
    And Show adjust 'Credit/Debit Note' lines items when clicked on invoice item
    And Error should be show at line item when input amount "999999" more than remaining invoice
    And Error should be show at line item when input amount "${EMPTY}" in text box
    And Error should be show at line item when input amount zero in text box
    And Show data correctly in create credit/debit note step2 when input amount "1" less than remaining







