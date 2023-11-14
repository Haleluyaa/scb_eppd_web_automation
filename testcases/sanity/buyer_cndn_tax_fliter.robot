*** Settings ***
Documentation 

### Global ###
Resource    ../../resources/global_lib.resource
Resource    ../../resources/global_var.resource
Resource    ../../resources/global_keyword.resource

### Keyword for Common/Reuse ###
Resource    ../../keywords/web/common/common_web_keywords.resource
Resource    ../../keywords/api/common/common_api_keywords.resource
Resource    ../../keywords/database/common/common_db_keywords.resource
Resource    ../../keywords/web/common/buyer_menu_keywords.resource
Resource    ../../keywords/web/cn_dn/cndn_history_keywords.resource

### Keyword Relate Page ###
Resource    ../../keywords/web/cn_dn/manage_cndn_keywords.resource
Resource    ../../keywords/web/cn_dn/manage_view_cndn_keywords.resource

### Keyword for thirdparty ###S
Resource    ../../keywords/web/thirdparty/common_ep_login_keywords.resource
Resource    ../../keywords/web/thirdparty/common_ep_invoice_link_keywords.resource


### Setup ### 
Suite Setup     Go to einvoice website from EP via "${TRUE_EP_WEB}" site with "${TRUE_VIEW_1}" and "${TRUE_PASSWORD}"
Suite Teardown     Run Keywords    Logout from eInvoice
                            ...    Delete All Cookies
                            ...    Close browser

Metadata    Version    1.0
Metadata    EXECUTE_AT    %{COMPUTERNAME}%


*** Test Cases ***

Verify filter tax invoice, with 'All CN/DN'
    [Documentation]    Verify einvoice show invoice both bad tax invoice and not tax invoice when choose 'No Filter'
                ...    Verify only data in first page
    [Tags]    Sanity    TaxInvoice    FilterTaxInvoice    CNDN

    Given Go to "Manage Credit/Debit Note" list via ${EINVOICE_URL_WEB} and path uri ${BUYER_MANAGE_CNDN_URI}
    When Buyer user choose filter tax invoice condition 'All CN/DN' in cndn status
    Then CNDN data show both cndn had 'Tax Invoice' and 'No Tax Invoice' in cndn status            

Verify filter tax invoice, with 'With Tax Invoice'
    [Documentation]    Verify einvoice show only invoice have tax number when filter with 'Tax Invoice'
                ...    Verify only data in first page
    [Tags]    Sanity    TaxInvoice    FilterTaxInvoice    CNDN

    Given Go to "Manage Credit/Debit Note" list via ${EINVOICE_URL_WEB} and path uri ${BUYER_MANAGE_CNDN_URI}
    When Buyer user choose filter tax invoice condition 'With Tax Invoice' in cndn status
    Then CNDN data show only cndn had 'Tax Invoice' in cndn status

Verify filter tax invoice, with 'No tax Invoice'
    [Documentation]    Verify einvoice show invoice both bad tax invoice and not tax invoice when choose 'No Filter'
                ...    Verify only data in first page
    [Tags]    Sanity    TaxInvoice    FilterTaxInvoice    CNDN

    Given Go to "Manage Credit/Debit Note" list via ${EINVOICE_URL_WEB} and path uri ${BUYER_MANAGE_CNDN_URI}
    When Buyer user choose filter tax invoice condition 'No Tax Invoice' in cndn status
    Then CNDN data show cndn had 'No Tax Invoice' in cndn status

  






        