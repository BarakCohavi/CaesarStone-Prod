*** Settings ***
Documentation    Creation Quick Quote Add(1 room,1 product)
Library    SeleniumLibrary
Resource    ../Processes/Common.robot
Resource    ../Processes/Create Qoute.robot

Suite Setup    Login Retailer.Initiate Web Tests    ${BROWSER}    ${BROWSER_OPTIONS}
Suite Teardown    Common.Terminate Web Tests

*** Variables ***
${BROWSER} =    chrome
${BROWSER_OPTIONS} =    add_argument("--start-maximized");add_argument("--disable-notifications");add_argument("--disable-popup-blocking");add_experimental_option('excludeSwitches', ['enable-logging']);add_argument("--window-size=1360,768");add_argument("--headless")



*** Test Cases ***
Create Qoute -> Edit -> Remove (QC)
    set selenium speed    0.5s
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
    click element    xpath://*[text()="Checkout Now"]
    wait until page contains element    xpath://*[text()="Save Quote"]     60s
    sleep    2s
     ${url} =   get title
    click element    xpath://*[text()="Save Quote"]
    capture page screenshot
    QC CREATED
    capture page screenshot
    wait until page does not contain element    xpath://*[text()="Save Quote"]    100s
    sleep    55s
    reload page
    wait until page contains element     xpath://div[text()="Job"]/parent::h1/div/span   120s
    ${CURJOB}=    get text    //div[text()="Job"]/parent::h1/div/span
    reload page
    wait until page contains element    xpath://div[text()="Job"]/parent::h1/div/span    60s
    Click Edit Quote QC
    capture page screenshot
    sleep    2s
    #Switch Window  title:Quote
    #scroll element into view   xpath://*[@class="DESKTOP comm-panels-container uiContainerManager siteforcePanelsContainer"]
    #capture page screenshot
    #SELECT FRAMES Edit
    #Delete Room
    #Checkout && Save Qoute
    #Varify Created Quote




*** Keywords ***
Delete Room
    capture page screenshot
    click element    xpath://*[@class="quotes-list__item-delete ui-delete"]
    capture page screenshot
    wait until page does not contain element    //*[@class="quotes-list__item-delete ui-delete"]   120s
    capture page screenshot
    sleep  4s


Varify Created Quote
     Wait Until Page Contains Element    xpath://*[text()="Installation Date Preference"]    60s
    scroll element into view    xpath://*[text()="Installation Date Preference"]
    wait until page contains element    xpath://*[text()="View All"]    90s
    scroll element into view    xpath://*[text()="View All"]
    click element    xpath://*[text()="View All"]
    sleep    2s
    capture page screenshot
    ${CountProducts}=    get element count    xpath:(//*[contains(text(),"Kitchen")])
    should be true    ${CountProducts}>=1


Checkout && Save Qoute
    click element    xpath://*[text()="Checkout Now"]
    wait until page contains element    xpath://*[text()="Save Quote"]     60s
    sleep    2s
    #${url} =   get title
    click element    xpath://*[text()="Save Quote"]
    capture page screenshot
    QC CREATED
    capture page screenshot
    wait until page does not contain element    xpath://*[text()="Save Quote"]    100s
    sleep    35s
    reload page