*** Settings ***
Documentation    Creation Quick Quote (1 room,1 product)
Library    SeleniumLibrary
Resource    ../Processes/Common.robot
Resource    ../Processes/Create Quick Quote.robot
Resource    ../Processes/Login Retailer.robot
Suite Setup    Login Retailer.Initiate Web Tests    ${BROWSER}    ${BROWSER_OPTIONS}
Suite Teardown    Common.Terminate Web Tests
*** Variables ***
${BROWSER} =    chrome
${BROWSER_OPTIONS} =    add_argument("--start-maximized");add_argument("--disable-notifications");add_argument("--disable-popup-blocking");add_experimental_option('excludeSwitches', ['enable-logging']);add_argument("--window-size=1360,768");add_argument("--headless");add_argument("--disable-gpu")


${room description} =    Kitchen 1

${Product in first_row} =    xpath:(//*[@class="slds-card__body"]/slot/c-quick-quote-item-list-row[1]/div/div[2]/c-search-autocomplete-selector/div/div/div/div/input[@placeholder="Search by name or code"])[1]
${Product in second_row} =    xpath:(//*[@class="slds-card__body"]/slot/c-quick-quote-item-list-row[2]/div/div[2]/c-search-autocomplete-selector/div/div/div/div/input[@placeholder="Search by name or code"])[1]
${Product in third_row} =    xpath:(//*[@class="slds-card__body"]/slot/c-quick-quote-item-list-row[3]/div/div[2]/c-search-autocomplete-selector/div/div/div/div/input[@placeholder="Search by name or code"])[1]
${Product in fourth_row} =    xpath:(//*[@class="slds-card__body"]/slot/c-quick-quote-item-list-row[4]/div/div[2]/c-search-autocomplete-selector/div/div/div/div/input[@placeholder="Search by name or code"])[1]

${first_dropDown_option of first Product} =     Adamina - 2cm
${first_dropDown_option of second Product} =     20mm Arris Edge
${first_dropDown_option of third Product} =     Additional Rough Cutout
${first_dropDown_option of fourth Product} =     Additional Rough Cutout

${Quantity in first_row} =    xpath:(//*[@class="slds-card__body"]/slot/c-quick-quote-item-list-row[1]/div/div[3]/lightning-input/div/input)[1]
${Quantity in second_row} =    xpath:(//*[@class="slds-card__body"]/slot/c-quick-quote-item-list-row[2]/div/div[3]/lightning-input/div/input)[1]
${Quantity in third_row} =    xpath:(//*[@class="slds-card__body"]/slot/c-quick-quote-item-list-row[3]/div/div[3]/lightning-input/div/input)[1]
${Quantity in fourth_row} =    xpath:(//*[@class="slds-card__body"]/slot/c-quick-quote-item-list-row[4]/div/div[3]/lightning-input/div/input)[1]

${Notes in fourth_row} =    xpath:(//*[@class="slds-card__body"]/slot/c-quick-quote-item-list-row[4]/div/div[4]/lightning-input/div/input)[1]



*** Test Cases ***
Create Quick Qoute one produst+room
    [Documentation]    This Test Case of Create QQ
    [Tags]    Quick qoute
    ${csConnectTest_Owner_aus1 page}=    ReadInput  2  5
    common.Navigating To "Experience As User"    ${csConnectTest_Owner_aus1 page}
    Clicking "Create Quick Quote" On Navbar
    Filling "Customer Details" Form
    capture page screenshot
    ADD ONE PRODUCT Submitting "Added Products"
    capture page screenshot
    Clicking "Yes"
    sleep    20s
    capture page screenshot
    Uploading File and Finishing "Quote" Creation
    capture page screenshot
    Verifying Quick Quote Was Created



*** Keywords ***
