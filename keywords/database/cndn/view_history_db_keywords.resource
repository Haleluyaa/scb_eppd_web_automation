*** Keywords ***
Get "CNDN History" header
    [Arguments]    ${invoice_number}
    ${query_string}    CATENATE
    ...    SELECT CNDN.CNDNNum AS CNDNNumber
    ...           ,GroupCNDN.BuyerNameEN AS [BuyerName]
    ...           ,FORMAT(CNDN.CNDNDate,'dd/MM/yyyy', 'en-US') AS [CreateDate]
    ...    FROM CNDN INNER JOIN GroupCNDN
    ...         ON CNDN.GroupID = GroupCNDN.GroupID
    ...    WHERE CNDNNum = '${invoice_number}'   

    [Return]    ${query_string} 

Get "CNDN History" action detail on supplier
    [Arguments]    ${invoice_number}
    ${query_string}    CATENATE
    ...    SELECT FORMAT(DATEADD(HOUR,7,LogDate), 'dd/MM/yyyy HH:mm', 'en-US')  AS [Date]
    ...           , Activity AS [Activity]
    ...           , CASE 
    ...                  WHEN Category != 'Submit' AND ActionBy != 'ERP' THEN (SELECT firstname FROM [RBAC_UAT].[dbo].[users] WHERE username = CNDNHistory.ActionBy) 
    ...                  WHEN Category != 'Submit' AND ActionBy = 'ERP' THEN 'ERP'
    ...                  WHEN Category = 'Submit' THEN ActionBy                            
    ...            END [ActionBy]   
    ...    FROM [CNDNHistory]
    ...         INNER JOIN [CNDN] ON CNDNHistory.CNDNID = CNDN.CNDNID
    ...    WHERE CNDN.CNDNNum = '${invoice_number}'
    ...          AND CNDNHistory.ActionBy <> 'ERP'
    ...    ORDER BY Date DESC
    [Return]    ${query_string}

Get "CNDN History" action detail on buyer
    [Arguments]    ${invoice_number}
    ${query_string}    CATENATE
    ...    SELECT FORMAT(DATEADD(HOUR,7,LogDate), 'dd/MM/yyyy HH:mm', 'en-US')  AS [Date]
    ...           ,REPLACE(REPLACE(REPLACE(Activity,'${SPACE}${SPACE}','<>'),'><',''),'<>',' ')
    ...   , CASE 
    ...         WHEN Category != 'Submit' AND ActionBy != 'ERP' THEN (SELECT firstname FROM [RBAC_UAT].[dbo].[users] WHERE username = CNDNHistory.ActionBy) 
    ...         WHEN Category != 'Submit' AND ActionBy = 'ERP' THEN 'ERP'
    ...         WHEN Category = 'Submit' THEN ActionBy
    ...    END [Concat_ActionBy]   
    ...    FROM [CNDNHistory]
    ...         INNER JOIN [CNDN] ON CNDNHistory.CNDNID = CNDN.CNDNID
    ...    WHERE CNDN.CNDNNum = '${invoice_number}'
    ...    ORDER BY Date DESC
    [Return]    ${query_string}  
    #Debug  



    
      
   

 
