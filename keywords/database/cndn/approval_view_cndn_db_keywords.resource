*** Keywords ***
Prepare query get person approver
    [Arguments]    ${cndn_num}
    [Documentation]    Prepare query for get approver detail include name, email and tel no.
                ...    When get only one approver

    ${query_string}    CATENATE   
    ...    SELECT     
    ...    CASE
    ...        WHEN users.lastname IS NULL THEN users.firstName
    ...        ELSE users.firstName + ' ' + users.lastname
    ...    END name 
    ...    , users.email
    ...    , users.phone 
    ...    FROM CNDNApproval AP1
    ...    INNER JOIN [RBAC_UAT].[dbo].[users] users ON AP1.Approver = users.username
    ...    INNER JOIN CNDNApproval AP2 ON AP1.CNDNApprovalID = AP2.CNDNApprovalID
    ...    INNER JOIN CNDN ON AP1.CNDNID = CNDN.CNDNID
    ...    WHERE CNDN.CNDNNum = '${cndn_num}' AND AP1.ApprovalTypeID = 1
    ...    AND users.username = AP2.Approver

    Return From Keyword    ${query_string}

Prepare query get group approver
    [Arguments]    ${cndn_number}
    [Documentation]    Prepare query for get approver detail include name, email and tel no.
                ...    When get only from a group approver in condition
                ...    Fix buyermp id to True (19553eee-b30a-46dd-b978-d75f807295ce)
                ...    Fix approver type to 2 (Account Payable)

    ${query_string}    CATENATE
    ...     SELECT 
    ...         CASE WHEN lastname IS NULL THEN RTRIM(LTRIM(firstName)) ELSE RTRIM(LTRIM(firstName)) + ' ' + RTRIM(LTRIM(lastName)) END name 
    ...         ,CASE WHEN users.email IS NULL THEN '' ELSE RTRIM(LTRIM(users.email)) END email 
    ...        ,CASE WHEN users.phone IS NULL THEN '' ELSE RTRIM(LTRIM(users.phone)) END phone 
    ...         ,GU.GroupUserID
    ...      FROM [RBAC_UAT].[dbo].[users] users 
    ...         INNER JOIN GroupUser GU ON GU.UserID = users.username
    ...     WHERE users.username IN (SELECT UserID FROM GroupUser GU 
    ...         INNER JOIN CNDNApproval AP ON GU.GroupUser = AP.ApproverGroup INNER JOIN CNDN ON CNDN.CNDNID = AP.CNDNID 
    ...     WHERE CNDN.CNDNNum = 'ROBOT-L1-AWAITING' 
    ...         AND AP.ApprovalTypeID = 2 
    ...         AND users.eId = ${eid}
    ...         AND users.buyerId = ${buyer_id}) AND GU.BuyerMpID = '${buyer_mpid}' 
    Return From Keyword      ${query_string}    