*** Settings ***
Documentation    Creation Simple Quote (QC) (1 room,1 product)
Library    SeleniumLibrary
Resource    ../Processes/Common.robot
Resource    ../Processes/Create Qoute.robot
Resource    ../Processes/Login Retailer.robot
Library    ../Processes/functions.py
Resource    ../Processes/EditeRemoveCreateQC.robot
Suite Setup    Login Retailer.Initiate Web Tests    ${BROWSER}    ${BROWSER_OPTIONS}
Suite Teardown    Common.Terminate Web Tests

*** Variables ***
${BROWSER} =    chrome
${BROWSER_OPTIONS} =    add_argument("--start-maximized");add_argument("--disable-notifications");add_argument("--disable-popup-blocking");add_experimental_option('excludeSwitches', ['enable-logging']);add_argument("--window-size=1360,768");add_argument("--headless")



*** Test Cases ***
Create Qoute one produst+room
    Create Qoute.Process1 (one room & product)
    capture page screenshot
    #${Total_Inc}=    get text    xpath:(//*[@class="dcart-column__value"])[2]
    ${Total_Exc}=    get text    xpath:(//*[@class="dcart-column__value"])[1]
    #${Total_Inc}=    substringg    ${Total_Inc}   #to cut the dolar
    ${Total_Inc}=    set variable    000
    ${Total_Exc}=    substringg    ${Total_Exc}
    ${Total_Exc}=    multiple10    ${Total_Exc}
    Create Qoute.Process2 (one room & product)
    sleep    35s
    reload page
    wait until page contains element   xpath://*[text()="Job"]    30s
    Check Price    ${Total_Inc}    ${Total_Exc}
    Varify Created Quote (one room & product)


