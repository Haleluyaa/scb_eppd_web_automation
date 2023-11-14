*** Setting ***
### Global ###
Resource    ../../resources/global_lib.resource
Resource    ../../resources/global_var.resource
Resource    ../../resources/global_keyword.resource
### Keyword for Common/Reuse ###
Resource    ../../keywords/web/common/common_web_keywords.resource
Resource    ../../keywords/web/thirdparty/common_ep_login_keywords.resource
Resource    ../../keywords/web/thirdparty/common_ep_invoice_link_keywords.resource
### Page keyword releted ###
Resource    ../../keywords/web/invoice/buyer_manage_invoice_list_keywords.resource

### Test Suite Data ###
Variables   ../../resources/testdata/${env}/sanity.yaml
Variables   ../../resources/testdata/${env}/thirdparty/buyer_manage_invoice.yaml

#Suite Setup
Suite Setup    Go to einvoice website from EP via "${TRUE_EP_WEB}" site with "${TRUE_VIEW_1}" and "${TRUE_PASSWORD}"
Suite Teardown     Run Keywords    Logout from eInvoice
                            ...    Delete All Cookies
                            ...    Close browser

*** Test Cases ***

Verify filter tax invoice, with 'No Filter'
    [Documentation]    Verify einvoice show invoice both bad tax invoice and not tax invoice when choose 'No Filter'
                ...    Verify only data in first page
    [Tags]    Sanity    TaxInvoice    FilterTaxInvoice    Invoice

    When Buyer user choose filter tax invoice condition 'All Invoice' in invoice status
    Then Invoice data show both invoice had 'Tax Invoice' and 'No Tax Invoice' in invoice status       

    [Teardown]    Reload Page     

Verify filter tax invoice, with 'With Tax Invoice'
    [Documentation]    Verify einvoice show only invoice have tax number when filter with 'Tax Invoice'
                ...    Verify only data in first page
    [Tags]    Sanity    TaxInvoice    FilterTaxInvoice    Invoice

    When Buyer user choose filter tax invoice condition 'With Tax Invoice' in invoice status
    Then Invoice data show only invoice had 'Tax Invoice' in invoice status

    [Teardown]    Reload Page

Verify filter tax invoice, with 'No tax Invoice'
    [Documentation]    Verify einvoice show invoice both bad tax invoice and not tax invoice when choose 'No Filter'
                ...    Verify only data in first page
    [Tags]    Sanity    TaxInvoice    FilterTaxInvoice    Invoice

    When Buyer user choose filter tax invoice condition 'No Tax Invoice' in invoice status
    Then Invoice data show invoice had 'No Tax Invoice' in invoice status

    [Teardown]    Reload Page

  






                