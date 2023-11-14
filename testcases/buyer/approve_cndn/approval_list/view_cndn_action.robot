*** Settings ***
### Global ###
Resource    ../../../../resources/global_lib.resource
Resource    ../../../../resources/global_var.resource
Resource    ../../../../resources/global_keyword.resource
### Keyword for Common/Reuse ###
Resource    ../../../../keywords/web/common/buyer_menu_keywords.resource
Resource    ../../../../keywords/web/common/common_web_keywords.resource
Resource    ../../../../keywords/api/common/common_api_keywords.resource
Resource    ../../../../keywords/database/common/common_db_keywords.resource
Resource    ../../../../keywords/web/thirdparty/common_ep_invoice_link_keywords.resource
Resource    ../../../../keywords/web/thirdparty/common_ep_login_keywords.resource
Resource    ../../../../keywords/web/common/buyer_menu_keywords.resource
Resource    ../../../../keywords/web/common/invoice_menu_keywords.resource
Variables   ../../../../resources/locators/common/invoice_menu_locator.yaml

### Page keyword releted ###
Resource    ../../../../keywords/web/cn_dn/cndn_approve_keywords.resource
Resource    ../../../../keywords/database/cndn/cndn_db_keywords.resource
Variables   ../../../../resources/locators/cn_dn/cndn_approve_locators.yaml
Variables   ../../../../resources/testdata/${env}/cn_dn/cndn.yaml
### Test Suite Data ###
Variables   ../../../../resources/testdata/${env}/thirdparty/buyer_manage_invoice.yaml
### Setup ### 
Suite Setup     Go to einvoice website from EP via "${TRUE_EP_WEB}" site with "${TRUE_APP_TYPE_2}" and "${TRUE_PASSWORD}" and go to cndn approve list        
Suite Teardown     Run Keywords    Delete All Cookies
                            ...    Close All browsers 
Test teardown       Run Keywords    Set value in DB for 'CN/DN approval status' as "${original_status}"
*** Variables ***

*** Test Cases ***
Verify CNDN list display action correctly in case CNDN approval status Approved for site true and user has permission (ici) (ipb)
    [Tags]      regression      medium    web   TC_eINVOICE_02504   Ready
    Given Get target CN/DN No. at column "${APPROVAL_TEXT.CNDN_NUMBER}" at row "${FIRST_ROW}"
    and Get target CN/DN Type at column "${APPROVAL_TEXT.CNDN_TYPE}" at row "${FIRST_ROW}"
    and Get target CN/DN Status at column "${APPROVAL_TEXT.STATUS}" at row "${FIRST_ROW}" and set variable 'original status'
    and Set value in DB for 'CN/DN approval status' as "${APPROVAL_STATUS.APPROVED}" 
    and Search Approval CN/DN with status "${APPROVAL_STATUS.APPROVED}"
    When Click action button at first row
    Then Action list should show 'Print Billing' at row number '1'
    and Action list should show 'History' at row number '2'    
 

Verify CNDN list display action correctly in case CNDN approval status Rejected for site true and user has permission (ici) (ipb)
    [Tags]      regression      medium    web   TC_eINVOICE_02505   Ready
    Given Get target CN/DN No. at column "${APPROVAL_TEXT.CNDN_NUMBER}" at row "${FIRST_ROW}"
    and Get target CN/DN Type at column "${APPROVAL_TEXT.CNDN_TYPE}" at row "${FIRST_ROW}"
    and Get target CN/DN Status at column "${APPROVAL_TEXT.STATUS}" at row "${FIRST_ROW}" and set variable 'original status'
    and Set value in DB for 'CN/DN approval status' as "${APPROVAL_STATUS.REJECTED}"
    and Search Approval CN/DN with status "${APPROVAL_STATUS.REJECTED}"
    When Click action button at first row
    Then Action list should show 'History' at row number '1'     


Verify CNDN list display action correctly in case CNDN approval status Processing for site true and user has permission (ici) (ipb)
    [Tags]      regression      medium    web   TC_eINVOICE_02506   Ready
    Given Get target CN/DN No. at column "${APPROVAL_TEXT.CNDN_NUMBER}" at row "${FIRST_ROW}"  
    and Get target CN/DN Type at column "${APPROVAL_TEXT.CNDN_TYPE}" at row "${FIRST_ROW}"
    and Get target CN/DN Status at column "${APPROVAL_TEXT.STATUS}" at row "${FIRST_ROW}" and set variable 'original status'
    and Set value in DB for 'CN/DN approval status' as "${APPROVAL_STATUS.PROCESSING}"
    and Search Approval CN/DN with status "${APPROVAL_STATUS.PROCESSING}"
    When Click action button at first row
    Then Action list should show 'Print Billing' at row number '1'
    and Action list should show 'History' at row number '2'   


Verify CNDN list display action correctly in case CNDN approval status Awaiting for site true and user has permission (ici) (ipb)
    [Tags]      regression      medium    web   TC_eINVOICE_02507   Ready
    Given Get target CN/DN No. at column "${APPROVAL_TEXT.CNDN_NUMBER}" at row "${FIRST_ROW}"
    and Get target CN/DN Type at column "${APPROVAL_TEXT.CNDN_TYPE}" at row "${FIRST_ROW}"
    and Get target CN/DN Status at column "${APPROVAL_TEXT.STATUS}" at row "${FIRST_ROW}" and set variable 'original status'
    and Set value in DB for 'CN/DN approval status' as "${APPROVAL_STATUS.AWAITING}"
    and Set value in DB for 'CN/DN status' as "${STATUS.AWAITING_APPROVAL}"
    and Search Approval CN/DN with status "${APPROVAL_STATUS.AWAITING}"
    When Click action button at first row
    Then Action list should show 'Edit' at row number '1'
    and Action list should show 'Close CN/DN' at row number '2'
    and Action list should show 'Print Billing' at row number '3'
    and Action list should show 'History' at row number '4'  

    [Teardown]       Run Keywords    Set value in DB for 'CN/DN approval status' as "${original_status}"
                     ...             Set value in DB for 'CN/DN status' as "${original_cndn_status}"