*** Settings ***
### Global ###
Resource    ../../../resources/global_lib.resource
Resource    ../../../resources/global_var.resource
Resource    ../../../resources/global_keyword.resource
### Keyword for Common/Reuse ###
Resource    ../../../keywords/web/common/buyer_menu_keywords.resource
Resource    ../../../keywords/web/common/common_web_keywords.resource
Resource    ../../../keywords/api/common/common_api_keywords.resource
Resource    ../../../keywords/database/common/common_db_keywords.resource
Resource    ../../../keywords/web/thirdparty/common_ep_login_keywords.resource
Resource    ../../../keywords/web/common/buyer_menu_keywords.resource
Resource    ../../../keywords/web/common/invoice_menu_keywords.resource
Resource    ../../../keywords/web/thirdparty/common_ep_invoice_link_keywords.resource
### Page keyword releted ###
Resource    ../../../keywords/web/cn_dn/cndn_approve_keywords.resource
Resource    ../../../keywords/web/cn_dn/approval_view_cndn_keywords.resource
Resource    ../../../keywords/database/cndn/cndn_db_keywords.resource
Variables   ../../../resources/locators/cn_dn/cndn_approve_locators.yaml
### Test Suite Data ###
Variables   ../../../resources/testdata/${env}/cn_dn/cndn.yaml
Variables   ../../../resources/testdata/${env}/thirdparty/buyer_manage_invoice.yaml

### Setup ###
Suite Setup     Go to einvoice website from EP via "${TRUE_EP_WEB}" site with "${TRUE_VERIFY_03}" and "${TRUE_PASSWORD}" and go to cndn approve list  
Suite Teardown    Run Keywords    Delete All Cookies
                           ...    Close All browsers

***Test Cases***
Request more CNDN information Modal has correct data
    [Documentation]    To verify that Request more CNDN information Modal has correct data
    [Tags]      Ready
    Given user search CNDN "${CNDN_NUMBER_NEED_INFORMATION}" which has information icon 
    When user clicked at CNDN which has information icon first row
    Then Hint Modal is shown
    and Modal shown correct data "${CNDN_NUMBER_NEED_INFORMATION}"