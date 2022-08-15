*** Settings ***
Library    SeleniumLibrary
Resource    Common.robot
Library    OperatingSystem
Library    functions.py
*** Variables ***
#${csConnectTest_Owner_aus1 page} =    https://caesarstone--cspartial.lightning.force.com/lightning/r/Contact/0035t000001ynRwAAI/view
#${cs connect_aus_fab1 page} =    https://caesarstone--cspartial.lightning.force.com/lightning/r/Contact/0035t000001ynS1AAI/view
${room description} =    Kitchen 1

${Product in first_row} =    xpath:(//*[@class="slds-card__body"]/slot/c-quick-quote-item-list-row[1]/div/div[2]/c-search-autocomplete-selector/div/div/div/div/div/input[@placeholder="Search by name or code"])[1]
${Product in second_row} =    xpath:(//*[@class="slds-card__body"]/slot/c-quick-quote-item-list-row[2]/div/div[2]/c-search-autocomplete-selector/div/div/div/div/div/input[@placeholder="Search by name or code"])[1]
${Product in third_row} =    xpath:(//*[@class="slds-card__body"]/slot/c-quick-quote-item-list-row[3]/div/div[2]/c-search-autocomplete-selector/div/div/div/div/div/input[@placeholder="Search by name or code"])[1]
${Product in fourth_row} =    xpath:(//*[@class="slds-card__body"]/slot/c-quick-quote-item-list-row[4]/div/div[2]/c-search-autocomplete-selector/div/div/div/div/div/input[@placeholder="Search by name or code"])[1]

${Product in fifth_row} =    xpath:(//*[@title="Other"]/c-quick-quote-item-list/lightning-card/article/*[@class="slds-card__body"]/slot/c-quick-quote-item-list-row[1]/div/div[2]/c-search-autocomplete-selector/div/div/div/div/div/input[@placeholder="Search by name or code"])[1]
${first_dropDown_option of first Product} =     Adamina - 2cm
${first_dropDown_option of second Product} =     20mm Arris Edge
${first_dropDown_option of third Product} =     Additional Rough Cutout
${first_dropDown_option of fourth Product} =     Additional Rough Cutout

${Quantity in first_row} =    xpath:(//*[@class="slds-card__body"]/slot/c-quick-quote-item-list-row[1]/div/div[3]/lightning-input/div/input)[1]
${Quantity in second_row} =    xpath:(//*[@class="slds-card__body"]/slot/c-quick-quote-item-list-row[2]/div/div[3]/lightning-input/div/input)[1]
${Quantity in third_row} =    xpath:(//*[@class="slds-card__body"]/slot/c-quick-quote-item-list-row[3]/div/div[3]/lightning-input/div/input)[1]
${Quantity in fourth_row} =    xpath:(//*[@class="slds-card__body"]/slot/c-quick-quote-item-list-row[4]/div/div[3]/lightning-input/div/input)[1]
${Quantity in fifth_row} =    xpath:(//*[@title="Other"]/c-quick-quote-item-list/lightning-card/article/*[@class="slds-card__body"]/slot/c-quick-quote-item-list-row[1]/div/div[3]/lightning-input/div/input)[1]
${Notes in fourth_row} =    xpath:(//*[@class="slds-card__body"]/slot/c-quick-quote-item-list-row[4]/div/div[4]/lightning-input/div/input)[1]

${CityInput}=    City
${path_File} =  ${EXECDIR}\\Input Files\\MyFile.pdf


*** Keywords ***
Process
    [Documentation]    Adding a New Quote to a Retailer
    [Tags]    Create
    ${csConnectTest_Owner_aus1 page}=    ReadInput  2  5
    common.Navigating To "Experience As User"    ${csConnectTest_Owner_aus1 page}
    Clicking "Create Quick Quote" On Navbar
    Filling "Customer Details" Form
    Submitting "Added Products"
    Clicking "Yes"
    Uploading File and Finishing "Quote" Creation
    Verifying "New Quote" Was Created
    go back
    wait until page contains element    xpath://div[text()="Job"]/parent::h1/div/span    100s



Clicking "Create Quick Quote" On Navbar
    Verify Being On "Retailer" Page
    click element    xpath://*[@id="6"]
    capture page screenshot
    sleep    4s
    ${present}=     get element count    xpath://*[text()="Please fill in the consumer details"]
    IF    ${present}==0
        Clicking "Create Quick Quote" On Navbar
    #ELSE
    END


Verify Being On "Retailer" Page
    Wait Until Page Contains Element    xpath://*[contains(text(),"Create Quick Quote")]    100s

Filling "Customer Details" Form
    Verify Being On "Customer Details" Page
    input text    firstName    Automated
    input text    lastName    Test
    Execute javascript    document.getElementsByTagName('email').value="caesarstone.testing@gmail.com"
    #input text    email    caesarstone.testing@gmail.com
    input text    phone    +1 586 789 9785
    scroll element into view    xpath://*[@name="country"]
    click element    xpath://*[@name="country"]
    click element    xpath://*[text()="Australia"]

    input text    postalCode    123456
    sleep    1s
    input text    xpath://*[@name="city"]    City
    click element    xpath://*[@name="province"]
    scroll element into view    xpath://*[@name="province"]
    click element    xpath://*[text()="Australian Capital Territory"]
    scroll element into view    xpath://*[text()="Next"]
    click button    Next

Verify Being On "Customer Details" Page
    Wait Until Page Contains Element    xpath://*[text()="Please fill in the consumer details"]    60s

Verify Being On "Add Products" Page
    Wait Until Page Contains Element    xpath://*[text()="Create room, add products and insert qty."]    60s
    page should contain button    Submit

Add Products To Quote
    input text    ${room description}    My Kitchen
    sleep    2s
    click element    ${Product in first_row}
    wait until page contains    Adamina
    #click element    ${first_dropDown_option of first Product}
    click element    xpath:(//*[@class="slds-card__body"]/slot/c-quick-quote-item-list-row[1]/div/div[2]/c-search-autocomplete-selector/div/div/div/div/div[2]/ul/c-search-autocomplete-selector-item[2]/li/div/span/span)[1]
    input text    ${Quantity in first_row}    2
    capture page screenshot


    click element    ${Product in second_row}
    #click element    ${first_dropDown_option of second Product}
    click element    xpath:(//*[@class="slds-card__body"]/slot/c-quick-quote-item-list-row[2]/div/div[2]/c-search-autocomplete-selector/div/div/div/div/div[2]/ul/c-search-autocomplete-selector-item[1]/li/div/span/span)[1]



    input text    ${Quantity in second_row}    4
    click element    ${Product in third_row}
    #click element    ${first_dropDown_option of third Product}
    click element    xpath:(//*[@class="slds-card__body"]/slot/c-quick-quote-item-list-row[3]/div/div[2]/c-search-autocomplete-selector/div/div/div/div/div[2]/ul/c-search-autocomplete-selector-item[1]/li/div/span/span)[1]

    input text    ${Quantity in third_row}    3
    click element    ${Product in fourth_row}
    #click element    ${first_dropDown_option of fourth Product}
    click element    xpath:(//*[@class="slds-card__body"]/slot/c-quick-quote-item-list-row[4]/div/div[2]/c-search-autocomplete-selector/div/div/div/div/div[2]/ul/c-search-autocomplete-selector-item[1]/li/div/span/span)[1]


    input text    ${Quantity in fourth_row}    3
    input text    ${Notes in fourth_row}    one spare


    #click element    ${Product in fifth_row}
    #click element    ${first_dropDown_option of fourth Product}
    #click element    xpath:(//*[@title="Other"]/c-quick-quote-item-list/lightning-card/article/*[@class="slds-card__body"]/slot/c-quick-quote-item-list-row[1]/div/div[2]/c-search-autocomplete-selector/div/div/div/div[2]/ul/c-search-autocomplete-selector-item[1]/li/div/span/span)[1]

    #input text    ${Quantity in fifth_row}    2
   # input text    ${Notes in fourth_row}    one spare






Submitting "Added Products"
    Verify Being On "Add Products" Page
    Add Products To Quote
    click button    Submit

Clicking "Yes"
    wait until page contains   Are you sure you want to create the quote?
    click button    Yes


Uploading File and Finishing "Quote" Creation
    Wait Until Page Contains Element    xpath://*[text()="Upload a File"]    60s
    click element    xpath://*[text()="Upload Files"]
    choose file    xpath://input[@name="fileUploader"]   ${path_File}
    Wait Until Page Contains Element    xpath://*[text()="1 of 1 file uploaded"]    60s
    click element    xpath://*[text()="Done"]
    Wait Until Page Contains Element    xpath://*[text()="Uploaded successfully!"]    60s
    click button    Finish

Verifying "New Quote" Was Created
    Wait Until Page Contains Element    xpath://*[text()="Mark Status as Complete"]    60s
    wait until page contains element    xpath://*[text()="View All"]    90s
    scroll element into view    xpath://*[text()="View All"]
    click element    xpath://*[text()="View All"]
    wait until page does not contain    COC Uploaded
    wait until page contains    Job Product Name
    Check There Quote With Products
    There Is Price More Than Zero For Every Product
    capture page screenshot


There Is Price More Than Zero For Every Product
    FOR    ${num}    IN RANGE    8
        IF   ${num}>2
            ${Price}=     get text    (//*[@data-aura-class="forceOutputCurrency"])[${num}]
            ${Price}=    ProductPrice1    ${Price}
            should be true    ${Price}>0
        END
    END
Check There Quote With Products
    ${CountProducts}=    get element count    xpath://*[contains(text(),"Kitchen 1")]
    should be true    ${CountProducts}>=5



Verifying Quick Quote Was Created
    Wait Until Page Contains Element    xpath://*[text()="Installation Date Preference"]    60s
    scroll element into view    xpath://*[text()="Installation Date Preference"]
    wait until page contains element    xpath://*[text()="View All"]    90s
    scroll element into view    xpath://*[text()="View All"]
    click element    xpath://*[text()="View All"]
    sleep    2s
    Check There Is A Product


Check There Is A Product
    capture page screenshot
    ${CountProducts}=    get element count    xpath:(//*[contains(text(),"Kitchen 1")])
    should be true    ${CountProducts}==2

Click Close
    Wait Until Page Contains Element    xpath://*[@class="slds-button slds-button--neutral closeBtn uiButton"]    60s
    click element    xpath://*[@class="slds-button slds-button--neutral closeBtn uiButton"]


ADD ONE PRODUCT Submitting "Added Products"
    Verify Being On "Add Products" Page
    Add One Product To Quote
    click button    Submit


Add One Product To Quote
    input text    ${room description}    My Kitchen
    sleep    2s
     FOR    ${i}    IN RANGE    25

         ${CountProducts}=    get element count    xpath://*[text()="Item List:"]/parent::h2/parent::div/parent::header/parent::div/parent::article/div/slot/c-quick-quote-item-list-row/div/div/lightning-button-icon
         ${Condition1}=    Evaluate    ${CountProducts} == 1
         Exit For Loop If    ${Condition1}
         click element    xpath://*[text()="Item List:"]/parent::h2/parent::div/parent::header/parent::div/parent::article/div/slot/c-quick-quote-item-list-row/div/div/lightning-button-icon

     END

    click element    xpath:(//*[@class="slds-card__body"]/slot/c-quick-quote-item-list-row[1]/div/div[2]/c-search-autocomplete-selector/div/div/div/div/div/input[@placeholder="Search by name or code"])[1]
    click element    xpath:(//*[@class="slds-card__body"]/slot/c-quick-quote-item-list-row[1]/div/div[2]/c-search-autocomplete-selector/div/div/div/div/div[2]/ul/c-search-autocomplete-selector-item[1]/li/div/span/span)[1]
    input text    ${Quantity in first_row}    3


    click element    ${Product in fifth_row}
    #click element    ${first_dropDown_option of fourth Product}
    click element    xpath:(//*[@title="Other"]/c-quick-quote-item-list/lightning-card/article/*[@class="slds-card__body"]/slot/c-quick-quote-item-list-row[1]/div/div[2]/c-search-autocomplete-selector/div/div/div/div/div[2]/ul/c-search-autocomplete-selector-item[1]/li/div/span/span)[1]

    input text    ${Quantity in fifth_row}    2

