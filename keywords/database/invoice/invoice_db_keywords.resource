*** Keywords ***
Get invoice id draft via supplier mpid and invoice number
    [Arguments]    ${supplier_mpid}    ${invoice_num}

    ${sql_statement}    CATENATE        
    ...    SELECT Invoice.InvoiceID
    ...    FROM Invoice INNER JOIN GroupInvoice ON Invoice.GroupID = GroupInvoice.GroupID
    ...    WHERE Invoice.InvoiceNum = '${invoice_num}' 
    ...    And Invoice.StatusID = 12
    ...    And Invoice.Deleted = 0
    ...    And GroupInvoice.SupplierMPID = '${supplier_mpid}'   
    @{invoice_id}    eInvoice Execute SELECT query string    ${sql_statement}

    [Return]    @{invoice_id}

Get invoice id via supplier mpid and invoice number
    [Arguments]    ${supplier_mpid}    ${invoice_num}

    ${sql_statement}    CATENATE        
    ...    SELECT Invoice.InvoiceID
    ...    FROM Invoice INNER JOIN GroupInvoice ON Invoice.GroupID = GroupInvoice.GroupID
    ...    WHERE Invoice.InvoiceNum = '${invoice_num}' 
    ...    And Invoice.StatusID <> 12
    ...    And Invoice.StatusID <> 4
    ...    And GroupInvoice.SupplierMPID = '${supplier_mpid}'   
    @{invoice_id}    eInvoice Execute SELECT query string    ${sql_statement}

    [Return]    @{invoice_id}    
