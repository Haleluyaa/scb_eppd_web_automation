*** Settings ***
Documentation 

### Global ###
Resource    ../../../resources/global_lib.resource
Resource    ../../../resources/global_var.resource
Resource    ../../../resources/global_keyword.resource

### Keyword for Common/Reuse ###
Resource    ../../../keywords/web/common/common_web_keywords.resource
Resource    ../../../keywords/api/common/common_api_keywords.resource
Resource    ../../../keywords/database/common/common_db_keywords.resource
Resource    ../../../keywords/web/common/buyer_menu_keywords.resource
Resource    ../../../keywords/web/cn_dn/cndn_history_keywords.resource

### Keyword Relate DB ###
Resource    ../../../keywords/database/cndn/view_history_db_keywords.resource

### Keyword Relate Page ###
Resource    ../../../keywords/web/cn_dn/manage_cndn_keywords.resource
Resource    ../../../keywords/web/cn_dn/manage_view_cndn_keywords.resource

### Keyword for thirdparty ###
Resource    ../../../keywords/web/thirdparty/common_ep_login_keywords.resource
Resource    ../../../keywords/web/thirdparty/common_ep_invoice_link_keywords.resource

### Test Suite Data ###
Variables   ../../../resources/testdata/${env}/cn_dn/cndn.yaml

### Setup ### 
Suite Setup     Go to einvoice website from EP via "${TRUE_EP_WEB}" site with "${TRUE_VERIFY_03}" and "${TRUE_PASSWORD}"
Suite Teardown     Run Keywords    Delete All Cookies
                            ...    Close All browsers

Metadata    Version    1.0
Metadata    EXECUTE_AT    %{COMPUTERNAME}

*** Test Cases ***
Invoice history for "Credit/Debit Note" at "Manage CNDN List" page should correctly
    [Tags]   Web  ManageCNDN  Buyer  ManageHistory  CNDNHistory  Regression  High  Ready    DB
    [Documentation]    Verify CNDN Histor on CNDN Status page from click menu History
                ...    When category equal submit then activity by 'name -username' else 'username'
                ...    But activity by 'ERP', displayed 'ERP'

    Given Go to "Manage Credit/Debit Note" list via ${EINVOICE_URL_WEB} and path uri ${BUYER_MANAGE_CNDN_URI}
    When Click menu history on specifice credit/debit note number "TRUEH-CN20191121"    
    Then History of CNDN "${var_cndn_number}" header should be display correct
    And History of CNDN "${var_cndn_number}" detail on buyer should be display correct

Invoice history for "Credit/Debit Note" at "Manage View CNDN Detail" page should correctly     
    [Tags]    Web  ManageCNDN  Buyer  ManageHistory  CNDNHistory  Regression  High  Ready    DB
    [Documentation]    Verify CNDN History on CNDN Detail form click menu History at top right corner
                    ...    When category equal submit then activity by 'name -username' else 'username'
                    ...    But activity by 'ERP', displayed 'ERP'

    Given Go to "Manage Credit/Debit Note" list via ${EINVOICE_URL_WEB} and path uri ${BUYER_MANAGE_CNDN_URI}
    #And Go to "view credit/debit note detail" at specifice credit/debit note on column "supplier" 
    And Go to "view credit/debit note detail" at specifice credit/debit note "TRUEH-CN20191121" on column "supplier" 
    When Click menu "History" at top right corner
    Then History of CNDN "${var_cndn_number}" header should be display correct
    And History of CNDN "${var_cndn_number}" detail on buyer should be display correct

