***Keywords***
Prepare statement get approval status and seq approved
    [Arguments]    ${invoice_num}    ${buyer_mpid}    ${supplier_mpid}
    ${sql_statement}    CATENATE    SELECT ApprovalStatus.ApprovalStatus,Approval.[SeqNum]
    ...    FROM [eInvoiceDB_UAT].[dbo].[Approval] INNER JOIN Invoice ON Invoice.InvoiceID = Approval.InvoiceID
    ...    INNER JOIN GroupInvoice ON Invoice.GroupID = GroupInvoice.GroupID
    ...    INNER JOIN ApprovalStatus ON ApprovalStatus.StatusID = Approval.ApprovalStatusID
    ...    WHERE Invoice.InvoiceNum = '${invoice_num}'
    ...    AND GroupInvoice.SupplierMPID = '${supplier_mpid}'
    ...    AND GroupInvoice.BuyerMpID = '${buyer_mpid}'
    ...    AND ApprovalStatus.BuyerMpID = 0

    [Return]    ${sql_statement}

