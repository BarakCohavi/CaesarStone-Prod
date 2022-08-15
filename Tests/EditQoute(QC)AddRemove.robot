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
    Click Edit Quote QC
    capture page screenshot
    Switch handle alert Edit
    SELECT FRAMES Edit
    CLICK ADD ROOM Edit
    Choose Room
    Add SPLASHBACK
    Add Edge2
    Add CUTOUTS & SPECIALY CUTS & ADDITIONAL TRAVEL Edit

    capture page screenshot


