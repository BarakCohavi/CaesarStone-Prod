*** Settings ***
Documentation    Creation Quick Quote Add(1 room,1 product)
Library    SeleniumLibrary
Resource    ../Processes/Create Qoute.robot

Suite Setup    Login Retailer.Initiate Web Tests    ${BROWSER}    ${BROWSER_OPTIONS}
Suite Teardown    Common.Terminate Web Tests

*** Variables ***
${BROWSER} =    chrome
${BROWSER_OPTIONS} =    add_argument("--start-maximized");add_argument("--disable-notifications");add_argument("--disable-popup-blocking");add_experimental_option('excludeSwitches', ['enable-logging']);add_argument("--window-size=1360,768");add_argument("--headless");add_argument("--disable-gpu")



*** Test Cases ***
Create Qoute one produst+room
    Create Qoute.Proccess

    ${var}=    get text    xpath://*[text()="Total Retail Price Inc GST"]/parent::div/following-sibling::div/span/span
    ${Old_Total_Inc}=    ProductPrice    ${var}
    ${var}=     get text    xpath://*[text()="Total Retail Price Exc GST"]/parent::div/following-sibling::div/span/span
    ${Old_Total_Exc}=    ProductPrice   ${var}
    ${Old_Total_Inc}=    cutComma    ${Old_Total_Inc}
    ${Old_Total_Exc}=    cutComma    ${Old_Total_Exc}

    Click Edit Quote QC
    capture page screenshot
    Switch handle alert Edit
    capture page screenshot
    SELECT FRAMES Edit
    #log to console    FRAMES
    CLICK ADD ROOM Edit
    Choose Room
    Add SPLASHBACK
    Add Edge2
    Add CUTOUTS & SPECIALY CUTS & ADDITIONAL TRAVEL Edit
    capture page screenshot
    ${Total_Inc}=    get text    xpath:(//*[@class="dcart-column__value"])[2]
    ${Total_Exc}=    get text    xpath:(//*[@class="dcart-column__value"])[1]
    ${Total_Inc}=    substringg    ${Total_Inc}   #to cut the dolar
    ${Total_Exc}=    substringg    ${Total_Exc}
    ${Total_Exc}=    multiple10    ${Total_Exc}
    #log to console    hi again
    click element    xpath://*[text()="Checkout Now"]
    wait until page contains element    xpath://*[text()="Save Quote"]     60s
    sleep    2s
     ${url} =   get title
    click element    xpath://*[text()="Save Quote"]

    capture page screenshot
    #log to console    swictch again plz
    QC CREATED
    capture page screenshot
    #SeleniumLibrary.switch window    ${url}
    wait until page does not contain element    xpath://*[text()="Save Quote"]    100s
    #Switch handle alert Edit
    #log to console    hi3
    #capture page screenshot
    #sleep    10s

    #View & Process Job
    sleep    35s
    reload page
    wait until page contains element     xpath://div[text()="Job"]/parent::h1/div/span   120s
    #log to console    yallah do it
    ${CURJOB}=    get text    //div[text()="Job"]/parent::h1/div/span
    #sleep    20s
    #Click Search CaesarStone Page1    ${CURJOB}
    reload page
    wait until page contains element    xpath://div[text()="Job"]/parent::h1/div/span    60s
    Check Price-1    ${Total_Exc}    ${Total_Inc}    #check if price same before saving and after
    Compare New And Old Total Price    ${Old_Total_Exc}    ${Total_Exc} #check if the price changed




*** Keywords ***
Compare New And Old Total Price
    [Arguments]        ${Old_Total_Exc}   ${Total_Exc}
    should be true    ${Total_Exc} >= ${Old_Total_Exc}
