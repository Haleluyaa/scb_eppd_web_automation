*** Settings ***
### Global ###
Resource    ../../../resources/global_lib.resource
Resource    ../../../resources/global_var.resource
Resource    ../../../resources/global_keyword.resource
### Keyword for Common/Reuse ###
Resource    ../../../keywords/web/common/common_web_keywords.resource
Resource    ../../../keywords/api/common/common_api_keywords.resource
Resource    ../../../keywords/database/common/common_db_keywords.resource
### Page keyword releted ###
Resource    ../../../keywords/web/cn_dn/cndn_status_keywords.resource
Resource    ../../../keywords/web/cn_dn/view_cndn_keywords.resource


### Test Suite Data ###
Variables   ../../../resources/testdata/${env}/cn_dn/cndn.yaml


### Setup ###
Suite Setup    Open setup browser with ${EINVOICE_URL_WEB} and ${BROWSER} and go to CN/DN supplier
Suite Teardown     Run Keywords    Delete All Cookies
                            ...    Close All browsers
Test Teardown   Run Keywords    Close tab and Go back to cndn status page
                        ...     Reload page

*** Test Cases ***
Print Billing action from CN/DN status page is working
    [Tags]    Ready    Regression    High    Web    TC_eINVOICE_02559
    [Documentation]    To Verify that Print Billing action from CN/DN status page is working properly
    Given Go to menu CN/DN
    When user select action button of any CN/DN that status is Awaiting Approval
    and click print billing
    Then Browser should open new tab with print preview of Billing Statement 

Print Billing action from CN/DN View page is working 
    [Tags]    Ready    Regression    High    Web    TC_eINVOICE_02560
    [Documentation]    To Verify that Print Billing action from CN/DN View page is working properly
    Given Go to menu CN/DN
    When user select any CN/DN that status is Awaiting Approval
    and click print billing in CN/DN view
    Then Browser should open new tab with print preview of Billing Statement 

Print Billing action from CN/DN status page is no visible if CN/DN status is Rejected, Document Returned, Expired, Cancelled
    [Tags]    Ready    Regression    High    Web    TC_eINVOICE_02563
    [Documentation]    To verify Print Billing action from CN/DN status page is no visible or accessible, if CN/DN status is Rejected, Document Returned, Expired, Cancelled
    Given Go to menu CN/DN
    When user select action button of any CN/DN that status is Rejected
    Then print billing button should not visible

Print Billing action from CN/DN View page is no visible if CN/DN status is Rejected, Document Returned, Expired, Cancelled
    [Tags]    Ready    Regression    High    Web    TC_eINVOICE_02564
    [Documentation]    To verify that Print Billing action from CN/DN View page is no visible and not accessible, if CN/DN status is Rejected, Document Returned, Expired, Cancelled
    Given Go to menu CN/DN
    When user select any CN/DN that status is Rejected
    Then print billing button should not visible
 
  