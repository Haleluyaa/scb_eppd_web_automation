*** Settings ***
### Global ###
Resource    ../../../resources/global_lib.resource
Resource    ../../../resources/global_var.resource
Resource    ../../../resources/global_keyword.resource
### Keyword for Common/Reuse ###
Resource    ../../../keywords/web/common/common_web_keywords.resource
Resource    ../../../keywords/api/common/common_api_keywords.resource
Resource    ../../../keywords/database/common/common_db_keywords.resource
### Keyword for thirdparty ###
Resource    ../../../keywords/web/thirdparty/common_ep_login_keywords.resource
Resource    ../../../keywords/web/thirdparty/common_ep_invoice_link_keywords.resource

### Page keyword releted ###
Resource    ../../../keywords/database/cndn/cndn_db_keywords.resource
Resource    ../../../keywords/web/invoice/buyer_approve_invoice_list_keywords.resource
#Resource    ../../../keywords/web/cn_dn/cndn_status_keywords.resource
Resource    ../../../keywords/web/cn_dn/approval_view_cndn_keywords.resource
Resource    ../../../keywords/web/cn_dn/cndn_approve_keywords.resource
Resource    ../../../keywords/web/cn_dn/cndn_history_keywords.resource
Resource    ../../../keywords/database/cndn/view_history_db_keywords.resource

### Test Suite Data ###
Variables   ../../../resources/testdata/${env}/cn_dn/cndn.yaml
### Setup ### 
Suite Setup      Go to einvoice website from EP via "${TRUE_EP_WEB}" site with "${TRUE_VERIFY_03}" and "${TRUE_PASSWORD}"
Suite Teardown     Run Keywords    Delete All Cookies
                            ...    Close All browsers

Metadata    Version    1.0
Metadata    EXECUTE_AT    %{COMPUTERNAME}                            

*** Test Cases ***
Invoice history for "Credit Note" and "Debit Note" should be display correct when click menu "History" on "CNDN Approve List Page"
    [Tags]    Web    Buyer    ApproveCNDN    CNDNApprove    CNDNHistory    regression    DB    TC_eINVOICE_02459    TC_eINVOICE_02460    Ready
    [Documentation]    Verify CNDN Histor on CNDN Status page from click menu History
                ...    When category equal submit then activity by 'name -username' else 'username'
                ...    But activity by 'ERP', displayed 'ERP'

    Given Go to "Approve CNDN" via URL on "${EINVOICE_URL_WEB}" and "${BUYER_APPROVE_CNDN_URI}" 
    When Click menu history on "TRUEH-CN20191121-001"
    Then History of CNDN "TRUEH-CN20191121-001" header should be display correct
    And History of CNDN "TRUEH-CN20191121-001" detail on buyer should be display correct    

Invoice history for "Credit Note" and "Debit Note" should be display correct when click menu "History" on "CNDN Approve Status Page"     
    [Tags]    Web    Buyer    ApproveCNDN    CNDNApprove    CNDNHistory    regression    DB    TC_eINVOICE_02461    TC_eINVOICE_02462    Ready  
    [Documentation]    Verify CNDN History on CNDN Detail form click menu History at top right corner
                ...    When category equal submit then activity by 'name -username' else 'username'
                ...    But activity by 'ERP', displayed 'ERP'

    Given Go to "Approve CNDN" via URL on "${EINVOICE_URL_WEB}" and "${BUYER_APPROVE_CNDN_URI}" 
    And Go to "View CNDN Detail" on specific invoice number "TRUEH-CN20191121-001" on column "Supplier" 
    When Click menu "History" at top right corner
    Then History of CNDN "TRUEH-CN20191121-001" header should be display correct
    And History of CNDN "TRUEH-CN20191121-001" detail on buyer should be display correct   