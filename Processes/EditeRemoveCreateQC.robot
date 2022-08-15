*** Settings ***
Library    SeleniumLibrary
Resource    ../Processes/Common.robot
Resource    ../Processes/Create Qoute.robot
Resource    ../Processes/Login Retailer.robot
Library    ../Processes/functions.py


*** Keywords ***
Check Price
    [Arguments]        ${Total_Inc}   ${Total_Exc}
    wait until page contains element      xpath://*[text()="Job Details"]    50s

    ${CURJOB}=    get text    //div[text()="Job"]/parent::h1/div/span
    sleep    5s
    Click Search CaesarStone Page    ${CURJOB}
    wait until page contains element    xpath://*[text()="Total Retail Price Exc GST"]/parent::div/following-sibling::div/span/span    50s
    sleep    7s
    reload page
   # FOR    ${num}    IN RANGE    999
        #${var}=    get text    xpath://*[text()="Total Retail Price Inc GST"]/parent::div/following-sibling::div/span/span
        #${Cur_Total_Inc}=    ProductPrice    ${var}
       # ${var}=     get text    xpath://*[text()="Total Retail Price Exc GST"]/parent::div/following-sibling::div/span/span
        #${Cur_Total_Exc}=    ProductPrice   ${var}
        #${Cur_Total_Inc}=    cutComma    ${Cur_Total_Inc}
        #${Cur_Total_Exc}=    cutComma    ${Cur_Total_Exc}
        #Exit For Loop If   ${Cur_Total_Exc}!='00.0'
        #Exit For Loop If    ${Cur_Total_Inc}!='00.0'

   # END
    sleep    7s
    reload page
    wait until page contains element    xpath://*[text()="Total Retail Price Exc GST"]/parent::div/following-sibling::div/span/span    50s

    #${var}=    get text    xpath://*[text()="Total Retail Price Inc GST"]/parent::div/following-sibling::div/span/span
    #${Cur_Total_Inc}=    ProductPrice    ${var}
    ${var}=     get text    xpath://*[text()="Total Retail Price Exc GST"]/parent::div/following-sibling::div/span/span
    ${Cur_Total_Exc}=    ProductPrice   ${var}
    #${Cur_Total_Inc}=    cutComma    ${Cur_Total_Inc}
    ${Cur_Total_Exc}=    cutComma    ${Cur_Total_Exc}
    scroll element into view    xpath://*[text()="Fabricator Comments"]
    capture page screenshot
    #should be true    ${Total_Inc} == ${Cur_Total_Inc}
    should be true    ${Total_Exc} == ${Cur_Total_Exc}

Check Price-1
    [Arguments]        ${Total_Inc}   ${Total_Exc}
    wait until page contains element      xpath://*[text()="Job Details"]    50s

    ${CURJOB}=    get text    //div[text()="Job"]/parent::h1/div/span
    sleep    5s
    Click Search CaesarStone Page    ${CURJOB}
    wait until page contains element    xpath://*[text()="Total Retail Price Exc GST"]/parent::div/following-sibling::div/span/span    50s
    sleep    7s
    reload page
   # FOR    ${num}    IN RANGE    999
        #${var}=    get text    xpath://*[text()="Total Retail Price Inc GST"]/parent::div/following-sibling::div/span/span
        #${Cur_Total_Inc}=    ProductPrice    ${var}
       # ${var}=     get text    xpath://*[text()="Total Retail Price Exc GST"]/parent::div/following-sibling::div/span/span
        #${Cur_Total_Exc}=    ProductPrice   ${var}
        #${Cur_Total_Inc}=    cutComma    ${Cur_Total_Inc}
        #${Cur_Total_Exc}=    cutComma    ${Cur_Total_Exc}
        #Exit For Loop If   ${Cur_Total_Exc}!='00.0'
        #Exit For Loop If    ${Cur_Total_Inc}!='00.0'

   # END
    sleep    7s
    reload page
    wait until page contains element    xpath://*[text()="Total Retail Price Exc GST"]/parent::div/following-sibling::div/span/span    50s

    ${var}=    get text    xpath://*[text()="Total Retail Price Inc GST"]/parent::div/following-sibling::div/span/span
    #${Cur_Total_Inc}=    ProductPrice    ${var}
    #${var}=     get text    xpath://*[text()="Total Retail Price Exc GST"]/parent::div/following-sibling::div/span/span
    ${Cur_Total_Exc}=    ProductPrice   ${var}
    #${Cur_Total_Inc}=    cutComma    ${Cur_Total_Inc}
    ${Cur_Total_Exc}=    cutComma    ${Cur_Total_Exc}
    scroll element into view    xpath://*[text()="Fabricator Comments"]
    capture page screenshot
    #should be true    ${Total_Inc} == ${Cur_Total_Inc}
    should be true    ${Total_Exc} == ${Cur_Total_Exc}


Varify Created Quote (one room & product)
    Wait Until Page Contains Element    xpath://*[text()="Installation Date Preference"]    60s
    scroll element into view    xpath://*[text()="Installation Date Preference"]
    wait until page contains element    xpath://*[text()="View All"]    90s
    scroll element into view    xpath://*[text()="View All"]
    click element    xpath://*[text()="View All"]
    sleep    2s
    capture page screenshot
    ${CountProducts}=    get element count    xpath:(//*[contains(text(),"Kitchen")])
    should be true    ${CountProducts}>2


Check Price1
    [Arguments]        ${Total_Inc}   ${Total_Exc}
    wait until page contains element      xpath://*[text()="Job Details"]    50s

    ${CURJOB}=    get text    //div[text()="Job"]/parent::h1/div/span
    sleep    5s
    Click Search CaesarStone Page    ${CURJOB}
    wait until page contains element    xpath://*[text()="Total Retail Price Exc GST"]/parent::div/following-sibling::div/span/span    50s
    sleep    7s
    reload page
   # FOR    ${num}    IN RANGE    999
        #${var}=    get text    xpath://*[text()="Total Retail Price Inc GST"]/parent::div/following-sibling::div/span/span
        #${Cur_Total_Inc}=    ProductPrice    ${var}
       # ${var}=     get text    xpath://*[text()="Total Retail Price Exc GST"]/parent::div/following-sibling::div/span/span
        #${Cur_Total_Exc}=    ProductPrice   ${var}
        #${Cur_Total_Inc}=    cutComma    ${Cur_Total_Inc}
        #${Cur_Total_Exc}=    cutComma    ${Cur_Total_Exc}
        #Exit For Loop If   ${Cur_Total_Exc}!='00.0'
        #Exit For Loop If    ${Cur_Total_Inc}!='00.0'

   # END
    sleep    7s
    reload page
    wait until page contains element    xpath://*[text()="Total Retail Price Exc GST"]/parent::div/following-sibling::div/span/span    50s

    #${var}=    get text    xpath://*[text()="Total Retail Price Inc GST"]/parent::div/following-sibling::div/span/span
    #${Cur_Total_Inc}=    ProductPrice    ${var}
    ${var}=     get text    xpath://*[text()="Total Retail Price Inc GST"]/parent::div/following-sibling::div/span/span
    ${Cur_Total_Exc}=    ProductPrice   ${var}
    #${Cur_Total_Inc}=    cutComma    ${Cur_Total_Inc}
    ${Cur_Total_Exc}=    cutComma    ${Cur_Total_Exc}
    scroll element into view    xpath://*[text()="Fabricator Comments"]
    capture page screenshot
    #should be true    ${Total_Inc} == ${Cur_Total_Inc}
    should be true    ${Total_Exc} == ${Cur_Total_Exc}