*** Settings ***
Variables    ../../../resources/locators/common/common_locators.yaml

*** Keywords ***
#### Loading page #####
Awaiting until loading screen not visible
    [Documentation]    This keyword wait for loading pages not visible on screen
    Sleep    2s
    ${IsElementVisible}=    Run Keyword And Return Status    Element Should Be Visible    ${loading_box}     #//*[@id="modalLoading"]
    Run Keyword If    ${IsElementVisible}    Wait Until Element Is Not Visible    ${loading_box}    #//*[@id="modalLoading"]

Wait until loading complete
    Run Keyword And Ignore Error    Wait Until Element Is Visible    ${loading_overflow}    2s
    Run Keyword And Ignore Error    Wait Until Page Does Not Contain Element     ${loading_overflow}    ${TIMEOUT} 

##########################################


#### Open browser session #####
Open browser with ${url} and ${browser}
    ${open_browser}=    Run keyword if    '${browser}'=='Chrome' or '${browser}'=='chrome'   Open normal browser ${url} and ${browser}
    ...    ELSE IF    '${browser}'=='Firefox' or '${browser}'=='firefox'     Open firefox browser ${url} and ${browser}
    ...    ELSE IF    '${browser}'=='IE' or '${browser}'=='ie'   Open internet explorer browser ${url} and ${browser}
    ...    ELSE IF    '${browser}'=='Edge' or '${browser}'=='edge'   Open edge browser ${url} and ${browser}
    ...    ELSE IF    '${browser}'=='Android' or '${browser}'=='android'    Open android browser ${url} and ${browser}
    ...    ELSE IF    '${browser}'=='IOS' or '${browser}'=='ios'   Open ios browser ${url} and ${browser}
    ...    ELSE IF    '${browser}'=='HeadlessChrome' or '${browser}'=='headlesschrome'    Open chrome browser in headless ${url} and ${browser}
    ...    ELSE IF    '${browser}'=='HeadlessFirefox' or '${browser}'=='headlessfirefox'   Open firefox browser in headless ${url} and ${browser}
    ...    ELSE IF    '${browser}'=='PabotChrome' or '${browser}'=='pabotchrome'   Open chorme browser via pabot on ${url} and chrome
    ...    ELSE    Open chrome as normal browser on ${url}     

Open setup browser with ${url} and ${browser} and go to invoice supplier
#    [Arguments]        ${browser}
    ${open_browser}=    Run keyword if    '${browser}'=='Chrome' or '${browser}'=='chrome'   Open normal browser ${url} and ${browser}
    ...    ELSE IF    '${browser}'=='Firefox' or '${browser}'=='firefox'     Open firefox browser ${url} and ${browser}
    ...    ELSE IF    '${browser}'=='IE' or '${browser}'=='ie'   Open internet explorer browser ${url} and ${browser}
    ...    ELSE IF    '${browser}'=='Edge' or '${browser}'=='edge'   Open edge browser ${url} and ${browser}
    ...    ELSE IF    '${browser}'=='Android' or '${browser}'=='android'    Open android browser ${url} and ${browser}
    ...    ELSE IF    '${browser}'=='IOS' or '${browser}'=='ios'   Open ios browser ${url} and ${browser}
    ...    ELSE IF    '${browser}'=='HeadlessChrome' or '${browser}'=='headlesschrome'    Open chrome browser in headless ${url} and ${browser}
    ...    ELSE IF    '${browser}'=='HeadlessFirefox' or '${browser}'=='headlessfirefox'   Open firefox browser in headless ${url} and ${browser}
    ...    ELSE IF    '${browser}'=='PabotChrome' or '${browser}'=='pabotchrome'   Open chorme browser via pabot on ${url} and chrome 
    ...    ELSE    Open chrome as normal browser on ${url}     
    Relog-in SWW via api then go to einvoice supplier with supplier guid   

Open setup browser with ${url} and ${browser} and go to invoice supplier with user TT00100
#    [Arguments]        ${browser}
    ${open_browser}=    Run keyword if    '${browser}'=='Chrome' or '${browser}'=='chrome'   Open normal browser ${url} and ${browser}
    ...    ELSE IF    '${browser}'=='Firefox' or '${browser}'=='firefox'     Open firefox browser ${url} and ${browser}
    ...    ELSE IF    '${browser}'=='IE' or '${browser}'=='ie'   Open internet explorer browser ${url} and ${browser}
    ...    ELSE IF    '${browser}'=='Edge' or '${browser}'=='edge'   Open edge browser ${url} and ${browser}
    ...    ELSE IF    '${browser}'=='Android' or '${browser}'=='android'    Open android browser ${url} and ${browser}
    ...    ELSE IF    '${browser}'=='IOS' or '${browser}'=='ios'   Open ios browser ${url} and ${browser}
    ...    ELSE IF    '${browser}'=='HeadlessChrome' or '${browser}'=='headlesschrome'    Open chrome browser in headless ${url} and ${browser}
    ...    ELSE IF    '${browser}'=='HeadlessFirefox' or '${browser}'=='headlessfirefox'   Open firefox browser in headless ${url} and ${browser}
    ...    ELSE IF    '${browser}'=='PabotChrome' or '${browser}'=='pabotchrome'   Open chorme browser via pabot on ${url} and chrome 
    ...    ELSE    Open chrome as normal browser on ${url}      
    Relog-in SWW via api then go to einvoice supplier with supplier guid for user TT00100       

Open setup browser with ${url} and ${browser} and go to CN/DN supplier
#    [Arguments]        ${browser}
    ${open_browser}=    Run keyword if    '${browser}'=='Chrome' or '${browser}'=='chrome'   Open normal browser ${url} and ${browser}
    ...    ELSE IF    '${browser}'=='Firefox' or '${browser}'=='firefox'     Open firefox browser ${url} and ${browser}
    ...    ELSE IF    '${browser}'=='IE' or '${browser}'=='ie'   Open internet explorer browser ${url} and ${browser}
    ...    ELSE IF    '${browser}'=='Edge' or '${browser}'=='edge'   Open edge browser ${url} and ${browser}
    ...    ELSE IF    '${browser}'=='Android' or '${browser}'=='android'    Open android browser ${url} and ${browser}
    ...    ELSE IF    '${browser}'=='IOS' or '${browser}'=='ios'   Open ios browser ${url} and ${browser}
    ...    ELSE IF    '${browser}'=='HeadlessChrome' or '${browser}'=='headlesschrome'    Open chrome browser in headless ${url} and ${browser}
    ...    ELSE IF    '${browser}'=='HeadlessFirefox' or '${browser}'=='headlessfirefox'   Open firefox browser in headless ${url} and ${browser}
    ...    ELSE IF    '${browser}'=='PabotChrome' or '${browser}'=='pabotchrome'   Open chorme browser via pabot on ${url} and chrome 
    ...    ELSE    Open chrome as normal browser on ${url}      
    Relog-in SWW via api then go to einvoice supplier with supplier guid   

Open normal browser ${url} and ${browser}
    Run Keyword And Ignore Error    Run     kill $(pgrep chromium)
    Open browser    ${url}    ${browser}
    Set Window Size     1920    1080

Open chrome as normal browser on ${url}  
    Run Keyword And Ignore Error    Run     kill $(pgrep chromium)
    Open browser    ${url}    chrome
    Set Window Size     1920    1080   

Open chorme browser via pabot on ${url} and chrome    
    Open browser    ${url}    chrome
    Set Window Size     1920    1080   

Open chrome browser in headless ${url} and ${browser}
    [Documentation]    If browser is google chrome, then open browser in headless mode
    @{chrome_arguments}    Create List    --disable-infobars    --headless    --disable-gpu

    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    : FOR    ${option}    IN    @{chrome_arguments}
    \    Call Method    ${options}    add_argument    ${option}

    Run Keyword And Ignore Error       Run          kill $(pgrep chromium)
    Create Webdriver    Chrome    chrome_options=${options}
    Set Selenium Speed    0.3s
    Set Browser Implicit Wait    0.1s
    Set Window Size     1920    1080
    Go to    ${url}

Open firefox browser ${url} and ${browser}
    Open browser    ${url}    ${browser}
    Maximize browser window

Open firefox browser in headless ${url} and ${browser}
    [Documentation]    If browser is google chrome, then open browser in headless mode
    @{firefox_arguments}    Create List    --disable-infobars    --headless    --disable-gpu

    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    : FOR    ${option}    IN    @{chrome_arguments}
    \    Call Method    ${options}    add_argument    ${option}

    Create Webdriver    Firefox    firefox_options=${options}
    Set Selenium Speed    0.3s
    Set Browser Implicit Wait    0.1s
    Set Window Size     1920    1080
    Go to    ${url}

Open internet explorer browser ${url} and ${browser}
    Open browser    ${url}    ${browser}
    Maximize browser window

Open edge browser ${url} and ${browser}
    Open browser    ${url}    ${browser}
    Maximize browser window

Open android browser ${url} and ${browser}
    Open browser    ${url}    ${browser}
    Maximize browser window

Open ios browser ${url} and ${browser}
    Open browser    ${url}    ${browser}
    Maximize browser window

Maybe Open Browser
    [Arguments]    ${URL}    ${BROWSER}    
    ${fail_keyword}=    Register Keyword To Run On Failure    Nothing
    ${status}=    Run Keyword And Return Status    Get Window Identifiers
    Register Keyword To Run On Failure    ${fail_keyword}
    Run Keyword Unless    '${status}' == 'False'    Return from keyword
    Open Browser    ${URL}    ${BROWSER}    

Scroll to bottom page
    Execute Javascript    window.scrollTo(0,document.body.scrollHeight)

Scroll to ${element_xpath} 
    #[Arguments]    ${element_xpath}
    Execute Javascript    document.evaluate("${element_xpath}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView();

Generate random number ${start} to ${end}
    #[Arguments]    ${start}    ${end}
    ${random_row}=    Evaluate    random.sample(range(${start}, ${end}), 1)    random
    [return]    ${random_row[0]}

Random integer  
    [Arguments]    ${start}    ${end}  
    [Documentation]    Random integer number in range 'start' and 'end'

    ${random_int}    random_int    ${start}    ${end}

    Return From Keyword    ${random_int}

Get current date in format 'yyyy-MM-dd'
    [Documentation]    Get current date and return in format yyyy-MM-dd

    ${current_date}    Evaluate    '{curr_date.year}-{curr_date.month}-{curr_date.day}'.format(curr_date=datetime.datetime.now())    modules=datetime

    [Return]    ${current_date}

Get current date in format 'dd/MM/yyyy'
    [Documentation]    Get current date and return in format dd/MM/yyyy

    ${current_date}    Evaluate    '{curr_date.day}/{curr_date.month}/{curr_date.year}'.format(curr_date=datetime.datetime.now())    modules=datetime

    [Return]    ${current_date}   

Get current date in format 'dd/MM/yyyy HH-mm'
    [Documentation]    Get current date and return in format dd/MM/yyyy

    ${current_date}    Evaluate    '{curr_date.day}/{curr_date.month}/{curr_date.year} {curr_date.hour}:{curr_date.minute}'.format(curr_date=datetime.datetime.now())    modules=datetime

    [Return]    ${current_date} 

Get current date and time in format 'yyyy-MM-dd HH:mm:ss'
    [Documentation]    Get current date and time and return in format yyyy-MM-dd HH:mm:ss

    ${current_datetime}    Evaluate   '{curr_date.year}-{curr_date.month}-{curr_date.day} {curr_date.hour}:{curr_date.minute}:{curr_date.second}'.format(curr_date=datetime.datetime.now())    modules=datetime    

    [Return]    ${current_datetime}

Generate random string Text
#    [Argument]    ${length}
    ${random_string}=    Generate Random String    4
    Set Test Variable    ${random_string}

Verify value ${value_locator} should be ${expected_value}
    #[Arguments]  ${value_locator}    ${expected_value}
    wait until element is visible    ${value_locator}
    ${current_value}=   get value    ${value_locator}
    should be equal as strings    ${expected_value}    ${current_value}

Verify text ${value_locator} should be ${expected_value}    
    #[Arguments]  ${value_locator}    ${expected_value}
    wait until element is visible    ${value_locator}
    ${current_value}=   get text    ${value_locator}
    should be equal as strings    ${expected_value}    ${current_value}


Verify integer value ${specific_value} should be ${expected_value}
    [Documentation]    This keyword for comapre integer value of expected value and specific value should be equal
               ...    ,received 2 arguments
    #[Arguments]    ${specific_value}    ${expected_value}
    #should be equal as integers    ${specific_value}    ${expected_value}
    Should Be True    ${specific_value} <= ${expected_value}


Verify text value ${value_locator} should be ${expected_value}   
    #[Arguments]  ${value_locator}    ${expected_value}
    wait until element is visible    ${value_locator}
    ${current_value}=   get text    ${value_locator}
    #element should contain    ${expected_value}    ${current_value}
    should be equal as strings    ${expected_value}    ${current_value}

Verify expected ${locator} should be visible
    [Documentation]    This keywords for verify element is display on web page, Expect locators as arguments
    #[Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}
    Element Should Be Visible    ${locator}   

Check over character limit ${Expected_locator} for ${Limitation_Amount}
    #[Arguments]    ${Expected_locator}    ${Limitation_Amount}
    ${Actual_Character}=    get value  ${Expected_locator}
    ${Actual_Character_Amount}=     get length  ${Actual_Character}
    should be equal as integers    ${Limitation_Amount}    ${Actual_Character_Amount}

Check validation error ${Error_locator} should be ${Expected_error}
    #[Arguments]    ${Error_locator}   ${Expected_error}
    wait until element is visible  ${Error_locator}
    ${Actual_error}=    get text  ${Error_locator}
    should be equal as strings  ${Expected_error}    ${Actual_error}

Clear textbox ${locator}
    #[Arguments]    ${locator}
    input text    ${locator}    1
    Press Keys    ${locator}    BACKSPACE

Press enter key ${expected_locators}
    #[Arguments]    ${expected_locators}
    Press Keys    ${expected_locators}    ENTER

Press tab key ${locator}
    #[Arguments]    ${locator}
    Press Keys    ${locator}    TAB

Press escape key
    Press Keys    ESCAPE

Clear textBox with enter delete button by ${input} parameter and ${locator}
    #[arguments]    ${Input}    ${locator}
    ${Input_lenght}=    Get Length    ${Input}
    :FOR    ${index}    IN RANGE    0    ${Input_lenght}
    \    Press Keys    ${locator}    BACKSPACE

Random date
    ${date}=    get current date    result_format=%Y-%m-%d %H:%M:%S.%f
    ${date}=    convert date    ${date}  epoch
    [return]  ${date}

Convert none to empty on ${my_var}
    #[Arguments]    ${my_var}
    ${status}    ${ignored}=    Run Keyword And Expect Error    Should Be Equal    ${my_var}    ${null}
    Set Variable If    "${status}" == "PASS"    ${EMPTY}    None
    [return]     ${NEW}

Get current date by format ${date_format} and adjust ${adjust_date}
    #[Arguments]    ${date_format}    ${adjust_date}
    [Documentation]    Get current date with specific format (Robot DateTime lib format) with plus adjust date from current date
    #Arguments format ex.  %d/%m/%Y    15 days   result is DD/MM/YYYY and current date plus 15 days
    #Arguments format ex2. %d-%m-%Y    0         result is DD-MM-YYYY and current date
    ${datetime}=    Get Current Date    result_format=%Y-%m-%d %H:%M:%S.%f
    ${OutputDate}=    Add Time To Date    ${datetime}    ${adjust_date}
    ${OutputDate}=    Convert Date    ${OutputDate}=    result_format=${date_format}
    [Return]    ${OutputDate}

Get current browser and version for ${Browser}
    #[Arguments]    ${Browser}
    [documentation]    this keyword will return result as chrome, firefox, ie 11, ie 10, ie 9, ie 8. the other browser beyond these are not support yet.
    ${browserVer}=    Run Keyword if    '${Browser}' == 'chrome'    Get Chrome Version
    ...   ELSE IF   '${Browser}' == 'firefox'    Get Firefox Version
    ...   ELSE IF   '${Browser}' == 'ie'    Get IE Version
    [return]     ${BrowserVer}

List should be equal as 
    [Arguments]    ${expected_list}    ${comparison_list}
    Lists Should Be Equal    ${expected_list}    ${comparison_list}   

Should be equal as string comparision and expected
    [Arguments]    ${actual}    ${expected}

    Should Be Equal As Strings     ${actual}    ${expected}           

Get Chrome Version
    ${agentHeader}=    Execute Javascript    return navigator.userAgent;
    Log    USER AGENT HEADER=${agentHeader}
    ${browserVer}=    Fetch From Right    ${agentHeader}      Chrome/
    ${browserVer}=    Fetch From Left     ${browserVer}    Safari
    log to console    CHROME VERSION=${browserVer}
    [return]    chrome

Get Firefox Version
    ${agentHeader}=    Execute Javascript    return navigator.userAgent;
    Log    USER AGENT HEADER=${agentHeader}
    ${browserVer}=    Fetch From Right    ${agentHeader}      Firefox/
    log to console    FIREFOX VERSION=${browserVer}
    [return]    firefox

Get IE version
    ${agentHeader}=    Execute Javascript    return navigator.userAgent;
    ${IsIE11}=    Run Keyword And Return Status     Should Contain    ${agentHeader}    rv:11
    ${browserVer}=    Run Keyword if    '${IsIE11}' == 'True'    Set Variable     ie 11
    ...    ELSE    Get IE8910 Version
    [return]    ${browserVer}

Get IE8910 Version
    ${agentHeader}=    Execute Javascript    return navigator.userAgent;
    Log    USER AGENT HEADER=${agentHeader}
    ${browserVer}=    Fetch From Right    ${agentHeader}     MSIE
    ${browserVer}=    Fetch From Left    ${browserVer}     .
    log to console    IE VERSION=${browserVer}
    [return]    ie${browserVer}

Get Data From Excel by Row x Column
    [Arguments]    ${excel_name}    ${row_no}    ${column_no}    ${sheet_name}
    Open Excel    ${excel_name}    useTempDir=False
    ${cell_data}    Read Cell Data By Coordinates    ${sheet_name}    ${column_no}    ${row_no}
    [Return]    ${cell_data}

Get Data Row From Excel
    [Arguments]    ${excel_name}    ${sheet_name}
    Open Excel    ${excel_name}    useTempDir=False
    ${row_count}    Get Row Count    ${sheet_name}
    [return]    ${row_count}    

Get digit value from decimal
    [Arguments]    ${text}
    ${match}=    Get Regexp Matches    ${text}    \d+\.(\d+)    1
    [Return]    ${match}

Check text length
    [Arguments]    ${text}    ${length}
    Log    ${text}
    ${text_len}=    Get Length    ${text}
    Should Be Equal As Integers    ${text_len}    ${length}    

Remove unwant strings
    [Arguments]    ${text}    ${remove_text}
    ${value}=    Remove String    ${text}    ${remove_text}
    [Return]    ${value}    

Relog-in SWW via api then go to einvoice supplier with supplier guid
    ##Hard code for supplier user : metro admin
    ${guid}    Get GUID From SWW via API
    Go to    ${EINVOICE_URL_WEB}?userGuid=${guid}&appType=EInvoiceSupplier

    Wait until loading complete

Relog-in SWW via api then go to einvoice supplier with supplier guid for user TT00100
    ##Hard code for supplier user : TT00100
    ${guid}    Get GUID from SWW via API for user TT00100
    Go to    ${EINVOICE_URL_WEB}?userGuid=${guid}&appType=EInvoiceSupplier

    Wait until loading complete    

Get supplier cookie  

    ${request_header}=    Get Cookie Value Of Invoice Supplier  

    [Return]    ${request_header}

Get and set headers for multipart form data   
    ${headers}=      Set api header content type multipart/form-data for invoice supplier 

    [Return]    &{headers}

Get Element Attribute From Locator
    [Documentation]    Get attribute value
    [Arguments]    ${locator}    ${attribute_type}
    Wait Until Element Is Visible    ${locator}    ${TIMEOUT}
    ${attribute_value}=    Get Element Attribute    ${locator}    ${attribute_type}
    [Return]    ${attribute_value}    

Prepare data to delete invoice session
    [Arguments]    ${gr_list}=empty
    ${gr_list}=    Get table row count from element    //*[@id="rb-tbl-pogr-list"]    6
    ${gr_list}=    Convert To String    ${gr_list}
    ${gr_list}=    Replace String    ${gr_list}    '    "
    ${gr_list}=    Remove String    ${gr_list}    u
    Set Global Variable    ${gr_list}
    Log    ${gr_list}   

Get current date system 
    ${current_datetime}    Get current date by format %Y-%m-%d and adjust 0
    ${current_year}    Get Substring    ${current_datetime}    0    3
    ${current_month}    Get Substring    ${current_datetime}    5    6
    ${current_date}    Get Substring    ${current_datetime}    7    8
    [Return]    ${current_year}    ${current_month}    ${current_date}

Select Calendar on ${expected_locator} for ${expected_year} and ${expected_month} and ${expected_day}
    [Documentation]    This keyword is using for selecting Date picker by inputting expected year, month, date
    #[Arguments]    ${expected_locator}    ${expected_year}    ${expected_month}    ${expected_day}
    Wait Until Element Is Visible    ${expected_locator}
    #Click Element    ${expected_locator}
    ${current_date_format} =    Get Current Date    result_format=datetime
    ${current_day} =    Set Variable    ${current_date_format.day}
    ${current_month} =    Set Variable    ${current_date_format.month}
    ${current_year} =    Set Variable    ${current_date_format.year}
    #${current_calendar}=   Get Element Attribute    xpath=(//td[contains(@class,'rc-calendar-cell')])[${current_day}]     title

    ${year_diff}=   Evaluate    int("${expected_year}")-int("${current_year}")
    ${month_diff}=  Evaluate    int("${expected_month}")-int("${current_month}")

    Run Keyword If  ${year_diff} < 0    Multiple Click On Previous Year Button  ${year_diff}
    Run Keyword If  ${year_diff} > 0    Multiple Click On Next Year Button  ${year_diff}

    Run Keyword If  ${month_diff} < 0    Multiple Click On Previous Month Button  ${month_diff}
    Run Keyword If  ${month_diff} > 0    Multiple Click On Next Month Button  ${month_diff}

    Click Element    xpath=//td[@class='rc-calendar-cell' and @title='${expected_year}-${expected_month}-${expected_day}']/div[@class='rc-calendar-date']    

# May created on 9/28/2018
Multiple Click On Next Year Button
    [Arguments]     ${click_times}
    Wait Until Element Is Visible    //a[@class='rc-calendar-next-year-btn']
    : FOR    ${INDEX}    IN RANGE    0    ${click_times}
    \    Click Element  //a[@class='rc-calendar-next-year-btn']

# May created on 9/28/2018
Multiple Click On Previous Year Button
    [Arguments]     ${click_times}
    Wait Until Element Is Visible    //a[@class='rc-calendar-prev-year-btn']
    ${click_times}=     Evaluate    abs(${click_times})
    : FOR    ${INDEX}    IN RANGE    0    ${click_times}
    \    Click Element  //a[@class='rc-calendar-prev-year-btn']

# May created on 9/28/2018
Multiple Click On Next Month Button
    [Arguments]     ${click_times}
    Wait Until Element Is Visible    xpath=//a[@class='rc-calendar-next-month-btn']
    : FOR    ${INDEX}    IN RANGE    0    ${click_times}
    \    Click Element  xpath=//a[@class='rc-calendar-next-month-btn']

# May created on 9/28/2018
Multiple Click On Previous Month Button
    [Arguments]     ${click_times}
    Wait Until Element Is Visible    xpath=//a[@class='rc-calendar-prev-month-btn']
    ${click_times}=    Evaluate    abs(${click_times})
    : FOR    ${INDEX}    IN RANGE    0    ${click_times}
    \    Click Element  xpath=//a[@class='rc-calendar-prev-month-btn']

Clear all cookie and session
    Delete invoice session
    Delete All Cookies

Clear all cookie and closed browser    
    Delete All Cookies
    Close All Browsers

Replace ${actual_string} from ${from_string} to ${to_string}
    Log    ${from_string}
    Log    ${to_string}
    ${return_string}    Replace String    ${actual_string}    ${from_string}    '${to_string}'
    [Return]    ${return_string}

Replaceing the locator of ${actual_string} from ${from_string} to integer ${to_int}
    Log    ${from_string}
    Log    ${to_int}
    ${return_string}    Replace String    ${actual_string}    ${from_string}    ${to_int}
    [Return]    ${return_string}    

Delete invoice session from solr   
    Delete invoice session 

Go to invoice supplier list
    Go to     ${einvoice_url_web}    
        
Get column number by target column name
    [Arguments]    ${target_column_name}    ${obj_head_row_with_td_or_th_items}
    [Documentation]    ${obj_head_row_with_td_or_th_items} = Example: //*[@class='frontend-items-list']//table//thead//th
                ...   this xpath will return each column items = 8 
                ...   Author: Peng 20191113
    ${column_number}=  Set Variable    0
    @{items}=  Get WebElements    ${obj_head_row_with_td_or_th_items}
    : FOR    ${item}    IN    @{items}   
    \   ${column_number}=    Evaluate    ${column_number} + 1
    \   ${actual_col_name}=   Get Text   ${item}
    \   Run Keyword If    '${actual_col_name.upper()}' == '${target_column_name.upper()}'    Exit For Loop    
    ${column_number}=    Evaluate    ${column_number} - 1
    [Return]   ${column_number}

Convert list to string with quote separate by comma
    [Arguments]     ${group_user_list}
    ${row_count}=    Get Length	    ${group_user_list}     
    ${string_list}=    Set Variable   '${group_user_list[0][0]}'
      :FOR    ${row_number}    IN RANGE    1    ${row_count}
     \    Exit For Loop If    "${row_number}" == "${row_count}"
     \    ${string_list}=    Set Variable    ${string_list},'${group_user_list[${row_number}][0]}'         
    [Return]    ${string_list}


Get access buyer cookie
    [Documentation]    Get cookie from buyer login
                ...    Include buyer_lang, buyer_auth and app_typ
                ...    Then extract to Test Variable

    ${cookie}    Get Cookies    buyer_auth

    ${buyer_lang}    Set Variable    ${cookie.buyer_lang}
    ${buyer_auth}    Set Variable    ${cookie.buyer_auth}
    ${buyer_app_type}    Set Variable    ${cookie.app_type}

    Set Suite Variable    ${buyer_lang}
    Set Suite Variable    ${buyer_auth}
    Set Suite Variable    ${buyer_app_type}

Get decode buyer auth 
    [Documentation]    Decode buyer auth token from jwt web token

    ${buyer_auth_decode}=    decode_jwt_token    ${buyer_auth} 

    Set Test Variable    ${buyer_auth_decode}

Get buyer eid from decode    
    [Documentation]    Get buyer eid from buyer cookie decode

    #Prepare variable for get EID    
    ${regexp_pattern}    Set Variable    "eid":"(.+?)"
    ${regexp_match_group}    Set Variable    1
    ${eid_index}    Set Variable    0

    ${data}    Get From Dictionary    ${buyer_auth_decode}    data
    ${eid_list_like}    Get Regexp Matches    ${data}    ${regexp_pattern}    ${regexp_match_group}

    ${eid}    Get From List    ${eid_list_like}    ${eid_index}

    Set Test Variable    ${eid}

Get buyer data from buyer auth    
    [Documentation]    Get buyer data from buyer auth
                ...    eid
                ...    Username
                ...    Buyer Name
                ...    Buyer email
                ...    Buyer phone
                ...    Buyer sid

    #Prepare variable for get EID    
    ${regexp_pattern_eid}    Set Variable    "eid":"(.+?)"
    ${regexp_pattern_username}    Set Variable    "sysUserId":"(.+?)"
    ${regexp_pattern_name}    Set Variable    "name":"(.+?)"
    ${regexp_pattern_email}    Set Variable    "email":"(.+?)"
    ${regexp_pattern_phone}    Set Variable    "phone":"(.+?)"
    ${regexp_pattern_sid}    Set Variable    "sid":"(.+?)"

    #Regex Group
    ${regexp_match_group}    Set Variable    1

    #Regex Index
    ${regex_index}    Set Variable    0


    ${data}    Get From Dictionary    ${buyer_auth_decode}    data
    ${eid_list_like}    Get Regexp Matches    ${data}    ${regexp_pattern_eid}    ${regexp_match_group}
    ${username_list_like}    Get Regexp Matches    ${data}    ${regexp_pattern_username}    ${regexp_match_group}
    ${name_list_like}    Get Regexp Matches    ${data}    ${regexp_pattern_name}    ${regexp_match_group}
    ${email_list_like}    Get Regexp Matches    ${data}    ${regexp_pattern_email}    ${regexp_match_group}
    ${phone_list_like}    Get Regexp Matches    ${data}    ${regexp_pattern_phone}    ${regexp_match_group}
    ${sid_list_like}    Get Regexp Matches    ${data}    ${regexp_pattern_sid}    ${regexp_match_group}
    #Get data from list-like at the first value
    ${buyer_eid}    Get From List    ${eid_list_like}    ${regex_index}
    ${buyer_username}    Get From List    ${username_list_like}    ${regex_index}
    ${buyer_name}    Get From List    ${name_list_like}    ${regex_index}
    ${buyer_email}    Get From List    ${email_list_like}    ${regex_index}
    ${buyer_phone}    Get From List    ${phone_list_like}    ${regex_index}
    ${buyer_sid}    Get From List    ${sid_list_like}    ${regex_index}

    #Assign to test variables scope
    Set Test Variable    ${buyer_eid}   
    Set Test Variable    ${buyer_username} 
    Set Test Variable    ${buyer_name} 
    Set Test Variable    ${buyer_email}
    Set Test Variable    ${buyer_phone} 
    Set Test Variable    ${buyer_sid}   

Get buyermpid and buyerid vie eid
    [Documentation]    Get buyer-mp-id and buyer-id from database
                ...    Via condition eid

    Get buyer eid from buyer_auth decode
    ${query_string}    Get buyermpid and buyerid from invoice database
    ${db_buyerinfo}    eInvoice Execute SELECT query string    ${query_string}

    ${buyer_mpid}    Set Variable    ${db_buyerinfo}[0][0]
    ${buyer_id}    Set Variable    ${db_buyerinfo}[0][1]

    Set Test Variable    ${buyer_mpid}
    Set Test Variable    ${buyer_id}    

Get buyer eid from buyer_auth decode    
    Get decode buyer auth
    Get buyer eid from decode

Get buyer data from token
    Get access buyer cookie    
    Get decode buyer auth
    Get buyer data from buyer auth 
    Get buyermpid and buyerid vie eid

Accept EP OptanonConsent on browser
    Sleep    1s
    ${status}    Run Keyword And Return Status    Element Should Be Visible    //button[@id="onetrust-accept-btn-handler"]    
    Run keyword If    ${status}    Click Element    //button[@id="onetrust-accept-btn-handler"]
        
    


