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
Resource    ../../../keywords/web/cn_dn/approval_cndn_keywords.resource
Resource    ../../../keywords/web/cn_dn/approval_view_cndn_keywords.resource
Resource    ../../../keywords/database/cndn/cndn_db_keywords.resource
### Test Suite Data ###
Variables   ../../../resources/testdata/${env}/cn_dn/approve_cndn.yaml
Variables   ../../../resources/testdata/${env}/common/login.yaml

### Setup ###
Suite Setup    Go to einvoice website from EP via "${TRUE_EP_WEB}" site with "${TRUE_VERIFY_03}" and "${TRUE_PASSWORD}"
Suite Teardown     Run Keywords    Delete All Cookies
                            ...    Close All browsers

*** Test Cases ***
Check SAP display details on Approve CNDN view detail
    [Tags]    Ready    Regression   Web    High 
    [Documentation]    To verify that SAP display details on Approve CNDN view detail is display correctly as database
    Given Go to menu approval CN/DN
    When user select CN/DN search filter and enter CN/DN number "${CNDN_NUMBER_SAP}" in search textbox
    and Click first row of CN/DN at column "${TEXT.BUYER}"
    Then system should display SAP details of "${CNDN_NUMBER_SAP}"
