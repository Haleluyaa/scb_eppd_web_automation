*** Keywords ***
Get gr detail on specific invoice and gr number
    [Arguments]    ${invoice_num}    ${gr_num}
    ${query_string}    CATENATE
    ...    SELECT CAST([GRLineNum] AS nvarchar) AS Item_No
    ...         ,[ItemDesc] AS Item_Name
	...         ,[Unit] AS Unit
    ...         ,FORMAT(InvItmDe.[ReceivedAmount],'N2')  AS GR_Amount
    ...         ,FORMAT(InvItmDe.[InvoiceAmount],'N2') AS Invoice_Amount
    ...         ,FORMAT(InvItmDe.[Retention],'N2') AS Retention
    ...    FROM [eInvoiceDB_UAT].[dbo].[InvoiceItemDetail] InvItmDe
    ...    INNER JOIN InvoiceItem InvItm ON InvItmDe.InvoiceItemID = InvItm.InvoiceItemID
	...    INNER JOIN Invoice Inv ON InvItm.InvoiceID = Inv.InvoiceID
    ...    WHERE Inv.InvoiceNum = '${invoice_num}' and InvItmDe.GRNum = '${gr_num}'
    [Return]    ${query_string}
