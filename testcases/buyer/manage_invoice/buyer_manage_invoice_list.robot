*** Settings ***
### Global ###
Resource    ../../../resources/global_lib.resource
Resource    ../../../resources/global_var.resource
Resource    ../../../resources/global_keyword.resource
### Keyword for Common/Reuse ###
Resource    ../../../keywords/web/common/buyer_menu_keywords.resource
Resource    ../../../keywords/api/common/common_api_keywords.resource
Resource    ../../../keywords/web/common/common_web_keywords.resource
### Page keyword releted ###
Resource    ../../../keywords/web/thirdparty/common_ep_login_keywords.resource
Resource    ../../../keywords/web/thirdparty/common_ep_invoice_link_keywords.resource
Resource    ../../../keywords/web/invoice/buyer_manage_invoice_list_keywords.resource
### Test Suite Data ###
Variables   ../../../resources/testdata/${env}/thirdparty/buyer_manage_invoice.yaml

### Setup ###
Suite Setup   Set Suite Variable    ${jason_buyer_path}    ${JSON_PATH.BUYER_MANAGE_INVOICE_ACTION} 
Test Setup    Open Browser    about:blank     chrome  
Test Teardown     Run Keywords    Logout from eInvoice    AND    Close All browsers

*** Test Cases ***
TC_eINVOICE_01112 - Verify action in Manage invoice page invoice list with account True App Type
    [Tags]      regression      high    web             
    Given Go to eInvoice via ep "${TRUE_EP_WEB}" site with "${TRUE_APP_TYPE_1}" and "${TRUE_PASSWORD}"    
    When Go to Manage invoice page
    Then Search invoice specific type and status with "${TRUE_APP_TYPE_1}" and "${TRUE_CODE}" then verify action displayed correctly

TC_eINVOICE_01112 - Verify action in Manage invoice page invoice list with account True View
    [Tags]      regression      high    web      
    Given Go to eInvoice via ep "${TRUE_EP_WEB}" site with "${TRUE_VIEW_1}" and "${TRUE_PASSWORD}"
    When Go to Manage invoice page
    Then Search invoice specific type and status with "${TRUE_VIEW_1}" and "${TRUE_CODE}" then verify action displayed correctly


*** Keywords ***
Go to eInvoice via ep "${site_name}" site with "${ep_username}" and "${ep_password}"
    Go to eInvoice via ep site, username and lastname    ${site_name}    ${ep_username}    ${ep_password}
    
Go to Manage invoice page
    Go to Manage invoice page by url   

Search invoice specific type and status with "${user_name}" and "${site_code}" then verify action displayed correctly
    ${jsonfile}  ${users}  ${user_index}=  Get user data in json append to list from    ${user_name}    ${jason_buyer_path}    ${site_code}    
    Loop for select status and search invoice by type then verify action    ${site_code}    ${jsonfile}    ${users}    ${user_index}  
    