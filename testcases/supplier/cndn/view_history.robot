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
Resource    ../../../keywords/database/cndn/cndn_db_keywords.resource
Resource    ../../../keywords/web/invoice/invoice_status_keywords.resource
Resource    ../../../keywords/web/cn_dn/cndn_status_keywords.resource
Resource    ../../../keywords/web/cn_dn/view_cndn_keywords.resource
Resource    ../../../keywords/web/cn_dn/cndn_history_keywords.resource
Resource    ../../../keywords/database/cndn/view_history_db_keywords.resource

### Test Suite Data ###
Variables   ../../../resources/testdata/${env}/cn_dn/cndn.yaml
### Setup ###
Suite Setup    Open setup browser with ${EINVOICE_URL_WEB} and ${BROWSER} and go to invoice supplier
Suite Teardown    Run Keywords    Delete All Cookies
                            ...    Close All browsers
test teardown   Reload page                            

Metadata    Version    1.0
Metadata    EXECUTE_AT    %{COMPUTERNAME}                            

*** Test Cases ***
Invoice history for "Credit Note" and "Debit Note" should be display correct when click menu "History" on "CNDN List Page"
    [Tags]    Web  Supplier  InvoiceCreditNoteDebitNote  SupplierCNDNList  CNDNHistory  regression    PTVNLK-795     TC_eINVOICE_02455    Ready    
    [Documentation]    Verify CNDN History on CNDN List from click menu History
                ...    When category equal submit then activity by 'name -username' else 'username'
                ...    But activity by 'ERP', displayed 'ERP'

    Given User go to invoice page
    And Go to menu CN/DN
    When Click menu history on "TRUEH-CN20191121-001"
    Then History of CNDN "TRUEH-CN20191121-001" header should be display correct
    And History of CNDN "TRUEH-CN20191121-001" detail on supplier should be display correct   

Invoice history for "Credit Note" and "Debit Note" should be display correct when click menu "History" on "CNDN Status Page"     
    [Tags]    Web  Supplier  InvoiceCreditNoteDebitNote  SupplierCNDNList  CNDNHistory  regression    PTVNLK-795    TC_eINVOICE_02456    Ready
    [Documentation]    Verify CNDN History on CNDN Detail form click menu History at top right corner
                ...    When category equal submit then activity by 'name -username' else 'username'
                ...    But activity by 'ERP', displayed 'ERP'
                
    Given User go to invoice page
    And Go to menu CN/DN
    And Go to "CNDN Staus Page" on specific invoice number "TRUEH-CN20191121-001" on column "Created Date"
    When Click menu "History" at top right corner
    Then History of CNDN "TRUEH-CN20191121-001" header should be display correct
    And History of CNDN "TRUEH-CN20191121-001" detail on supplier should be display correct  




