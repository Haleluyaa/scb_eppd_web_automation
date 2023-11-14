*** Settings ***
### Global ###
Resource    ../../../resources/global_lib.resource
Resource    ../../../resources/global_var.resource
Resource    ../../../resources/global_keyword.resource
### Keyword for Common/Reuse ###
Resource    ../../../keywords/web/common/common_web_keywords.resource
Resource    ../../../keywords/api/common/common_api_keywords.resource
Resource    ../../../keywords/database/common/common_db_keywords.resource
Resource    ../../../keywords/web/thirdparty/common_ep_invoice_link_keywords.resource
Resource    ../../../keywords/web/thirdparty/common_ep_login_keywords.resource
Resource    ../../../keywords/web/common/buyer_menu_keywords.resource
Resource    ../../../keywords/web/common/invoice_menu_keywords.resource
Variables   ../../../resources/locators/common/invoice_menu_locator.yaml
### Page keyword releted ###
Resource    ../../../keywords/web/cn_dn/manage_cndn_keywords.resource
Resource    ../../../keywords/web/cn_dn/manage_view_cndn_keywords.resource
Resource    ../../../keywords/database/cndn/cndn_db_keywords.resource
### Test Suite Data ###
Variables   ../../../resources/testdata/${env}/cn_dn/cndn.yaml
### Setup ###
Suite Setup     Go to einvoice website from EP via "${TRUE_EP_WEB}" site with "${TRUE_VERIFY_03}" and "${TRUE_PASSWORD}"
Suite Teardown     Run Keywords    Delete All Cookies
                            ...    Close All browsers
Test Teardown       Click 'X' mark to close 'View CNDN' page

*** Test Cases ***
"View Credit/ Debit note" page shoud display data properly when click each row from "CN/DN status"
    [Tags]   regression      high    web    DB  Ready
    [Documentation]  Verify new page is implemented and pass data to display on that page   
    Given Click menu cn/dn
    and Go to menu Manage CN/DN     
    When Go to 'View CN/DN detail page' of CN/DN Number "dontusemycndn3"
    Then Verify page 'CN/DN' detail display
    and Message for Header section display all expected "${MANAGE_MESSAGE_HEADER_SECTION}" correctly
    and Message for Credit/Debit note section display all expected "${MESSAGE_CNDN_SECTION}" correctly
    and Message for Invoice section display all expected "${MESSAGE_INVOICE_SECTION}" correctly
    and View CN/DN detail page of CN/DN Number "dontusemycndn3" should match with DB

"Due Date" ,"Payment Location" and "Note to Buyer" should hide if data in database is NULL
    [Tags]      regression      high    web    DB   Ready
    [Documentation]  Verify label should display on detail section in 'View Credit / Debit Note' page is heiden if has NULL value in DB    
    Given Click menu cn/dn
    and Go to menu Manage CN/DN 
    When Go to 'View CN/DN detail page' of CN/DN Number "TRUEH-DN20191126-03"
    Then Verify page 'CN/DN' detail display
    and "Due Date", "Payment Location" and "Note to Buyer" is hidden