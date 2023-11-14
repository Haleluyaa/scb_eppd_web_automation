*** Keywords ***
Get Deleted flag invoice in db      
    [Arguments]     ${invoice_number}
    ${sql}=    CATENATE     select deleted from invoice where invoicenum = '${invoice_number}'
    ${return}=  eInvoice Execute SELECT query string    ${sql}
    [Return]    ${return[0][0]}    

Set Deleted flag invoice in db    
    [Arguments]    ${flag}  ${invoice_number}
    ${sql}=    CATENATE     UPDATE invoice SET deleted = ${flag} where invoicenum = '${invoice_number}'
    ${return_status}=  eInvoice Execute INSERT, UPDATE, DELETE query string    ${sql} 