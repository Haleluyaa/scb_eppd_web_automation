*** Settings ***
### Global ###
Resource    ../../../resources/global_lib.resource
Resource    ../../../resources/global_var.resource
Resource    ../../../resources/global_keyword.resource
### Keyword for Common/Reuse ###
Resource    ../../../keywords/api/common/common_api_keywords.resource
Resource    ../../../keywords/web/common/common_web_keywords.resource
### Keyword for thirdparty ###
Resource    ../../../keywords/web/thirdparty/common_ep_login_keywords.resource
Resource    ../../../keywords/web/common/invoice_menu_keywords.resource
Resource    ../../../keywords/web/thirdparty/common_ep_invoice_link_keywords.resource
Resource    ../../../keywords/database/common/common_db_keywords.resource
### Page keyword releted ###
Resource    ../../../keywords/web/cn_dn/manage_cndn_keywords.resource
Resource    ../../../keywords/database/cndn/cndn_db_keywords.resource
Variables   ../../../resources/testdata/${env}/thirdparty/buyer_manage_invoice.yaml
Variables   ../../../resources/testdata/${env}/cn_dn/approve_cndn.yaml
### Test Suite Data ###
Suite Setup     Go to einvoice website from EP via "${TRUE_EP_WEB}" site with "${TRUE_VERIFY_03}" and "${TRUE_PASSWORD}"
Suite Teardown     Run Keywords    Delete All Cookies
                            ...    Close All browsers
### Setup ###
Test teardown    Reload Page

*** Test Cases ***
"Manage CN/DN" display all "Credit / Debit Note" by logged in account
    [Tags]      regression      high    web    DB   Ready          
    [Documentation]  Verify data display correctly meet to condition
    Given Click menu cn/dn
    and Go to menu Manage CN/DN
    When User select status filter "Awaiting Approval"
    Then Result table display CN/DN with "Awaiting Approval"
    and Result table display "Awaiting Approval" status item sorting by 'Create Date' as DESC

Column "CN/DN Number" shows icon "Tax Invoice" when has tax invoice and show balloon message "Tax Invoice" when mouse over icon
    [Tags]      regression      high    web    DB   Ready
    [Documentation]  Verify icon is display if there is Tax Invoice
    Given Click menu cn/dn
    and Go to menu Manage CN/DN
    When User select status filter "Awaiting Approval"
    and Click icon 'tax filter' in column 'CN/DN Number'
    and Select "With Tax Invoice" in dropdown list
    and Get target CN/DN No. at column "${TEXT.CNDN_NUMBER}" at row "${FIRST_ROW}" 
    and Click expand CN/DN for first row           
    Then Result table display CN/DN with "Awaiting Approval"
    and There is icon 'Tax Invoice' in column 'CN/DN Number'  
    and Verify fields expansion CN/DN should show all detail correctly   

"Buyer Reference" number is shown when there is value in CN/DN
    [Tags]      regression      high    web    DB    Ready
    [Documentation]  Verify "Buyer Reference" is generated and display.
                ...     *** Always generated after approved CN/DN
    Given Click menu cn/dn
    and Go to menu Manage CN/DN
    and Search CN/DN by CN/DN Number "dontusemycndn3"
    and Click expand CN/DN for first row
    Then 'Buyer Referance' number "BLN1091-19000002-001" is display in column "CN/DN Number"    
    and 'Buyer Referance' number "BLN1091-19000002" is display next to 'Referance Number' in CN/DN expansion
    and CN/DN expansion display fields "Reference No.", "Invoice Number", "PO Number​", "GR Number", "Cost Center", "No." and "Item Name"

"Cost Center" column display properly 
    [Tags]      regression      high    web    DB   Ready
    [Documentation]  Verify "Cost Center" display as DB configulation in case customer site is "TRUE"
    Given Click menu cn/dn
    and Go to menu Manage CN/DN
    When User select status filter "Awaiting"
    Then Result table display field name "Cost Center"