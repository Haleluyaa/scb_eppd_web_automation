*** Settings ***
### Global ###
Resource    ../../../resources/global_lib.resource
Resource    ../../../resources/global_var.resource
Resource    ../../../resources/global_keyword.resource

### Keyword for Common/Reuse ###
Resource    ../../../keywords/web/common/common_web_keywords.resource
Resource    ../../../keywords/api/common/common_api_keywords.resource
Resource    ../../../keywords/database/common/common_db_keywords.resource
Resource    ../../../keywords/web/common/buyer_menu_keywords.resource

### Page keyword releted ###
Resource    ../../../keywords/web/invoice/invoice_status_keywords.resource

### Keyword Relate Page ###
Resource    ../../../keywords/web/cn_dn/manage_cndn_keywords.resource
Resource    ../../../keywords/web/cn_dn/manage_view_cndn_keywords.resource

### Keyword Relate DB ###
Resource    ../../../keywords/database/cndn/manage_view_cndn_db_keywords.resource
Resource    ../../../keywords/database/cndn/cndn_db_keywords.resource
Resource    ../../../keywords/database/common/common_buyer_info_db_keywords.resource

### Keyword for thirdparty ###
Resource    ../../../keywords/web/thirdparty/common_ep_login_keywords.resource
Resource    ../../../keywords/web/thirdparty/common_ep_invoice_link_keywords.resource


### Test Suite Data ###
Variables   ../../../resources/testdata/${env}/cn_dn/cndn.yaml

### Set Up ###
Suite Setup     Go to einvoice website from EP via "${TRUE_EP_WEB}" site with "${TRUE_VERIFY_03}" and "${TRUE_PASSWORD}"
Suite Teardown     Run Keywords    Delete All Cookies
                            ...    Close All browsers

Force Tags    ManageCNDN    Buyer   WEb    InvoiceCreditNoteDebitNote    ManageCNDNDetail

*** Test Cases ***
To verify approval flow on credit/debit note status is "Rejected"
    [Tags]    ViewApproval    regression    Ready
    [Documentation]    Verify CDND Approval flow when CNDN Number had status "Rejected";
                ...    verify part of display icon, etc.  
                ...    Login with approval level 1 : Verify Document 
    
    Given Go to "Manage Credit/Debit Note" list via ${EINVOICE_URL_WEB} and path uri ${BUYER_MANAGE_CNDN_URI}
    And Go to "view credit/debit note detail" at specifice credit/debit note "ROBOT-L1-REJECTED" on column "supplier" 
    Then Verify the 'Credit/Debit Note' Rejected Status should be correctly witn note "Reject by boaw"

To verify approval flow on credit/debit note status is "Completed"
    [Tags]    ViewApproval    regression    Ready
    [Documentation]    Verify CNDN Approval flow when CNDN Number had status "Approved";
                ...    verify part of display icon, etc.
                ...    Login with approval level 1 : Verify Document
    
    Given Go to "Manage Credit/Debit Note" list via ${EINVOICE_URL_WEB} and path uri ${BUYER_MANAGE_CNDN_URI}
    And Go to "view credit/debit note detail" at specifice credit/debit note "ROBOT-L2-COMPLETED" on column "supplier" 
    Then Verify the 'Credit/Debit Note' Completed Status should be correctly

To verify approval flow on credit/debit note status is "Awaiting Approve" on Level2
    [Tags]    ViewApproval    regression    Ready
    [Documentation]    Verify CNDN Approval flow when CNDN Number had status "Awaiting";
                ...    verify part of display icon, etc.
                ...    Login with approval level 1 : Verify Document

    Given Go to "Manage Credit/Debit Note" list via ${EINVOICE_URL_WEB} and path uri ${BUYER_MANAGE_CNDN_URI}
    And Go to "view credit/debit note detail" at specifice credit/debit note "ROBOT-L1-APPROVE" on column "supplier" 
    Then Verify the 'Credit/Debit Note' Awaiting Approver Status on Level2 should be correctly

To verify approval flow on credit/debit note status is "Pending"
    [Tags]    ViewApproval    regression    Ready
    [Documentation]    Verify CNDN Approval flow when CNDN Number had status "Pending";
                ...    verify part of display icon, etc.
                ...    Login with approval level 1 : verify document

    Given Go to "Manage Credit/Debit Note" list via ${EINVOICE_URL_WEB} and path uri ${BUYER_MANAGE_CNDN_URI}
    And Go to "view credit/debit note detail" at specifice credit/debit note "ROBOT-L1-AWAITING1" on column "supplier"     ### Waiting changed cn/dn number
    Then Verify the 'Credit/Debit Note' Pending Status should be correctly

To verify approval flow on credit/debit note status is 'Completed' from Closed CN/DN 
    [Tags]    ViewApproval    regression    TEST2
    [Documentation]    Verify CNDN Approval flow when CNDN Number had status "Completed" from Closed CN/DN;
                ...    verify part of display icon, etc.
                ...    Login with approval level 1 : verify document

    Given Go to "Manage Credit/Debit Note" list via ${EINVOICE_URL_WEB} and path uri ${BUYER_MANAGE_CNDN_URI}
    And Go to "view credit/debit note detail" at specifice credit/debit note "REF-CN20200107-09" on column "supplier" 
    Then Verify the 'Credit/Debit Note' Completed Status form Closed CN/DN should be correctly 
    
To verify approval flow is "Group Approval"
    [Tags]    ViewApproval    DB    regression    Ready
    [Documentation]    Verify display label and approval detail when approver is an Approval Group

    Given Go to "Manage Credit/Debit Note" list via ${EINVOICE_URL_WEB} and path uri ${BUYER_MANAGE_CNDN_URI}
    And Go to "view credit/debit note detail" at specifice credit/debit note "ROBOT-L1-AWAITING" on column "supplier" 
    When Click on the second approval box
    Then Verify the system show group approval correct on credit/debit note "ROBOT-L1-AWAITING"

To verify approval flow is "Personal"
    [Tags]    ViewApproval    DB    regression    Ready
    [Documentation]    Verify display label and approval detail when approver is a Person
    
    Given Go to "Manage Credit/Debit Note" list via ${EINVOICE_URL_WEB} and path uri ${BUYER_MANAGE_CNDN_URI}
    And Go to "view credit/debit note detail" at specifice credit/debit note "ROBOT-L1-AWAITING" on column "supplier" 
    When Click on the first approval box
    Then Verify the system show a person approval correct on credit/debit note "ROBOT-L1-AWAITING"


