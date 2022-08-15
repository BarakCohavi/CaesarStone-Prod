*** Settings ***
Documentation    Creation Quick Quote Add(1 room,1 product)
Library    SeleniumLibrary
Resource    ../Processes/Create Quick Quote.robot
Resource    ../Processes/Login Retailer.robot
Resource    ../Processes/EditOrRemoveQuote.robot
Suite Setup    Login Retailer.Initiate Web Tests    ${BROWSER}    ${BROWSER_OPTIONS}
Suite Teardown    Common.Terminate Web Tests
*** Variables ***
${BROWSER} =    chrome
${BROWSER_OPTIONS} =    add_argument("--start-maximized");add_argument("--disable-notifications");add_argument("--disable-popup-blocking");add_experimental_option('excludeSwitches', ['enable-logging']);add_argument("--window-size=1360,768");add_argument("--headless")


*** Test Cases ***
EditQuote-QQ-add
    [Tags]    Edit QQ Add Room+Product
    create quick quote.process
    Click Edit Quote
    Add New Product To The Current room
    Add New Room
    Add Products To New Room
    Submit Changing
    Uploading File and Finishing "Quote" Creation
    Verifying "New Quote" Was Changed

