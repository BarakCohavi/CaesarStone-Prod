*** Settings ***
Library    SeleniumLibrary
Library    ../Processes/functions.py


*** Keywords ***
 Create new Fabricator account and fill the fields
    scroll element into view    xpath://*[text()="Account Name"]/parent::label/following-sibling::div/div/div/div/input
    ${randomNumber}=    randomNumber    1000    9999
    input text    //*[text()="Account Name"]/parent::label/following-sibling::div/div/div/div/input    Automated test ${randomNumber}
    ${randomNumber}=    randomNumber    100000000    999999999
    input text    //*[text()="Company No."]/parent::label/following-sibling::input    ${randomNumber}
    ${randomNumber}=    randomNumber    10000000    99999999
    input text    //*[@type="tel"]    05${randomNumber}
    ${randomNumber}=    randomNumber    1000000    9999999
    #input text    //*[text()="Account Email"]/parent::label/following-sibling::input    QualitestTest+${randomNumber}@gmail.com
    Execute javascript    document.getElementsByClassName('input')[8].value='QualitestTest+${randomNumber}@gmail.com';




    capture page screenshot
    scroll element into view    //*[text()="Legal Name"]
    ${randomNumber}=    randomNumber    1    99
    input text    //*[text()="Legal Name"]/parent::label/following-sibling::input    LegalName${randomNumber}


    scroll element into view    xpath://*[text()="Search Address"]
    select checkbox    //*[text()="Paying Account"]/parent::label/following-sibling::input
    click element    //*[text()="Country"]/parent::span/following-sibling::div/div/div/div/a
    capture page screenshot
    ${randomNumber}=    randomNumber    2    50
    scroll element into view    //*[@class="select-options"]/ul/li[${randomNumber}]
    click element    //*[@class="select-options"]/ul/li[${randomNumber}]
    capture page screenshot
    #ADRESS
    input text    //*[text()="Street"]/parent::label/following-sibling::textarea     37 Murphy Street
    input text    //*[text()="Zip/Postal Code"]/parent::label/following-sibling::input    3387
    input text    //*[text()="City"]/parent::label/following-sibling::input    Oak Park
    scroll element into view    xpath://*[text()="Region"]/parent::span/following-sibling::div
    click element    //*[text()="Region"]/parent::span/following-sibling::div
    ${randomNumber}=    randomNumber    2    15
    scroll element into view    (//*[@class="select-options"]/ul/li[${randomNumber}])[2]
    click element    (//*[@class="select-options"]/ul/li[${randomNumber}])[2]      #New England

    scroll element into view    xpath://*[text()="CS Connect Account Manager"]
    click element    //*[text()="CS Connect?"]/parent::span/following-sibling::div/div/div/div/a
    click element    //*[text()="Yes, CS Connect Service Provider"]

    click element    //*[text()="Account Pricing Level"]/parent::span/following-sibling::div/div/div/div/a
    click element    //*[text()="Platinum"]

    #scroll element into view    //*[text()="Needs To Be Charged For Slabs"]/parent::span/following-sibling::div/div/div/div/a
    click element    //*[text()="Needs To Be Charged For Slabs"]/parent::span/following-sibling::div/div/div/div/a
    sleep    0.5s
    click element    (//*[text()="No"])[2]
    scroll element into view    xpath://*[text()="Bill To Usage ID"]
    input text    //*[text()="ORG ID"]/parent::label/following-sibling::input    201
    click element    xpath://*[@title="Save"]
    wait until page does not contain element    xpath://*[@title="Save"]    60s
    sleep    3s

Varify Creation By Check Log In

    wait until page contains element    xpath://*[@class="slds-button slds-button_icon-border-filled"]    30s
    sleep    2s
    wait until element is enabled    xpath://*[@class="slds-button slds-button_icon-border-filled"]    30s
    click element    xpath:(//*[@class="slds-button slds-button_icon-border-filled"])
    page should contain element    xpath://*[text()="Log in to Experience as User"]
    capture page screenshot



Create new K&B account and fill the fields
    ${randomNumber}=    randomNumber    1000    9999
    input text    xpath://*[text()="Account Name"]/parent::label/following-sibling::div/div/div/div/input    Automated test ${randomNumber}
    ${randomNumber}=    randomNumber    100000000    999999999
    input text    //*[text()="Company No."]/parent::label/following-sibling::input    ${randomNumber}
    ${randomNumber}=    randomNumber    10000000    99999999
    input text    //*[@type="tel"]    05${randomNumber}
    ${randomNumber}=    randomNumber    1000000    9999999
    #input text    //*[text()="Account Email"]/parent::label/following-sibling::input    QualitestTest+${randomNumber}@gmail.com
    Execute javascript    document.getElementsByClassName('input')[5].value='QualitestTest+${randomNumber}@gmail.com';

    capture page screenshot

    scroll element into view    //*[text()="Legal Name"]
    ${randomNumber}=    randomNumber    1    99
    input text    //*[text()="Legal Name"]/parent::label/following-sibling::input    LegalName${randomNumber}


    scroll element into view    xpath://*[text()="Search Address"]
    select checkbox    //*[text()="Paying Account"]/parent::label/following-sibling::input
    click element    //*[text()="Country"]/parent::span/following-sibling::div/div/div/div/a
    capture page screenshot
    ${randomNumber}=    randomNumber    2    50
    scroll element into view    //*[@class="select-options"]/ul/li[${randomNumber}]
    click element    //*[@class="select-options"]/ul/li[${randomNumber}]
    capture page screenshot
    #ADRESS
    input text    //*[text()="Street"]/parent::label/following-sibling::textarea     37 Murphy Street
    input text    //*[text()="Zip/Postal Code"]/parent::label/following-sibling::input    3387
    input text    //*[text()="City"]/parent::label/following-sibling::input    Oak Park
    scroll element into view    xpath://*[text()="State Manager"]
    click element    //*[text()="Region"]/parent::span/following-sibling::div
    ${randomNumber}=    randomNumber    2    15
    scroll element into view    (//*[@class="select-options"]/ul/li[${randomNumber}])[2]
    click element    (//*[@class="select-options"]/ul/li[${randomNumber}])[2]      #New England

    scroll element into view    xpath://*[text()="CS Connect Account Manager"]
    click element    //*[text()="CS Connect?"]/parent::span/following-sibling::div/div/div/div/a
    click element    //*[text()="Yes, CS Connect Retailer"]

    click element    //*[text()="Account Pricing Level"]/parent::span/following-sibling::div/div/div/div/a
    click element    //*[text()="Platinum"]

    scroll element into view    xpath://*[text()="SLX Account Id"]
    input text    //*[text()="ORG ID"]/parent::label/following-sibling::input    201
    click element    xpath://*[@title="Save"]
    wait until page does not contain element    xpath://*[@title="Save"]    60s
    sleep    3s


varify New Account created
    wait until element is visible    xpath://*[@class="slds-button slds-button_icon-border-filled"]    60s
    wait until element is visible    xpath:(//*[text()="Account Name"])[2]    60s
    scroll element into view    xpath://*[text()="Account Email"]
    #wait until element is visible    xpath://*[text()="Account Name"]    60s
    scroll element into view    xpath://*[text()="Ship To Usage ID"]
    ${Sync_status}=    get text    xpath://*[text()="Sync"]/parent::div/following-sibling::div/span/slot/lightning-formatted-text
    #page should contain element    xpath://*[text()="Successful"]
    should not be empty    ${Sync_status}





Step 2 - New Contact
    click element    xpath://*[@class="slds-button slds-button_icon-border-filled"]
    ${CountElement}=    get element count    xpath://*[text()="New Contact"]
    IF    ${CountElement}==0
    click element    xpath://*[@class="slds-button slds-button_icon-border-filled"]
    END
    click element    xpath://*[text()="New Contact"]
    wait until page contains element    //*[@class="firstName compoundBorderBottom form-element__row input"]    60s

    #New Contact Info
    ${randomNumber}=    randomNumber    100    999
    ${contact}    set variable    Contacttest ${randomNumber}
    input text    //*[@class="firstName compoundBorderBottom form-element__row input"]    ${contact}
    ${randomNumber}=    randomNumber    10    99
    input text    //*[@class="lastName compoundBorderBottom form-element__row input"]    Last ${randomNumber}
    ${randomNumber}=    randomNumber    1000000    9999999
    #input text    (//*[@class="input"])[5]    QualitestTest+Contact${randomNumber}@gmail.com
    Execute javascript    document.getElementsByClassName('input')[5].value='QualitestTest+Contact${randomNumber}@gmail.co';
    capture page screenshot
    press key    xpath:(//*[@inputmode="email"])[1]    m
    capture page screenshot
    ${randomNumber}=    randomNumber    10000000    99999999
    input text    (//*[@type="tel"])[2]    05${randomNumber}
    input text    (//*[@type="tel"])[1]    05${randomNumber}
    capture page screenshot
    click element    //*[text()="Mailing Country"]/parent::span/following-sibling::div/div/div/div/a
    capture page screenshot
    ${randomNumber}=    randomNumber    1    99
    scroll element into view    //*[@class="select-options"]/ul/li[${randomNumber}]
    click element    //*[@class="select-options"]/ul/li[${randomNumber}]
    capture page screenshot
    ${randomNumber}=    randomNumber    100    999
    input text    //*[text()="Mailing Street"]/parent::label/following-sibling::textarea     ${randomNumber} Street
    ${randomNumber}=    randomNumber    1000    9999
    input text    //*[text()="Mailing Zip/Postal Code"]/parent::label/following-sibling::input     ${randomNumber}
    ${randomNumber}=    randomNumber    100    999
    input text    //*[text()="Mailing City"]/parent::label/following-sibling::input    City${randomNumber}


    scroll element into view     //*[text()="Mailing Country"]/parent::span/following-sibling::div/div/div/div/a
    #Execute javascript    document.getElementsByClassName('input')[5].value='QualitestTest+Contact${randomNumber}@gmail.com';
    capture page screenshot

    mouse down    xpath://*[@class="slds-button slds-button_brand cuf-publisherShareButton undefined uiButton"]
    mouse up    xpath://*[@class="slds-button slds-button_brand cuf-publisherShareButton undefined uiButton"]
    wait until page does not contain element    xpath://*[text()="Mailing City"]/parent::label/following-sibling::input    30s
    wait until page contains element    xpath://*[contains(text(),"Contacttest")]    60s

    scroll element into view    xpath:(//*[text()="Financial Details"])
    #${VAR}=    get text    xpath:(//*[@class="custom-truncate uiOutputText"])[1]
    [Return]    ${contact}

Save Contact
    scroll element into view    xpath:(//*[@class="slds-truncate slds-m-right--xx-small"])[1]
    sleep    2s
    mouse down    xpath:(//*[@class="slds-truncate slds-m-right--xx-small"])[1]
    mouse up      xpath:(//*[@class="slds-truncate slds-m-right--xx-small"])[1]

Search Contact-1
    [Arguments]    ${VAR}
    click element    xpath:(//*[@data-key="search"])[1]
    sleep    1s
    input text   (//*[@type="search"])[5]    ${VAR}
    #click element    xpath://*[@title="Search"]
    #sleep    10s
    Wait Until Page Contains Element    xpath://*[@title="${VAR}"]    60s
    capture page screenshot
    #click element       xpath:(//lightning-formatted-rich-text)[11]
    capture page screenshot

Scroll To Element
    [Arguments]    ${scroll_to_element}
    ${x} =    Get Horizontal Position    ${scroll_to_element}
    ${y} =    Get Vertical Position      ${scroll_to_element}
    Execute Javascript    window.scrollTo(${x}, ${y})


Select Edit Access to CS Connect & Primary Owner
    [Arguments]    ${VAR}
    wait until page contains element    xpath:(//*[text()="User Creation Failure Reason"])    30s
    ${present}=     get element count    xpath:(//*[text()="Account Manager"])
    IF    ${present}==0
        ${present}=     get element count    xpath:(//h2/a[@title="${VAR}"])
        IF    ${present}==1
            click element    xpath:(//h2/a[@title="${VAR}"])
        END
    END
    #wait until page contains element    xpath:(//*[text()="Contact Owner"])    40s
    sleep    2s
    scroll element into view    xpath:(//*[text()="User Creation Failure Reason"])

    click element    xpath://*[@title="Edit Access to CS Connect"]
    sleep    0.5s

    Scroll To Element   xpath:(//*[text()="Created By"])
    sleep    0.5s
    capture page screenshot
    Scroll To Element    xpath:(//*[@name="PrimaryOwner__c"])

    select checkbox    xpath:(//*[@name="CommunityUser__c"])
    wait until page contains element    xpath:(//*[@title="Owner"])   30s
    click element    xpath:(//*[@title="Owner"])[2]
    click element    xpath:(//*[@title="Move selection to Chosen"])[2]
    scroll element into view    //*[text()="Mailing City"]
    capture page screenshot
    sleep    1s
    scroll element into view    xpath:(//*[@name="CommunityUser__c"])
    wait until page contains element    (//*[@title="Owner"])[1]    30s
    select checkbox    xpath:(//*[@name="PrimaryOwner__c"])
    click element    xpath:(//*[@title="Owner"])[1]
    click element    xpath:(//*[@title="Move selection to Chosen"])[1]
    sleep    0.5s
    scroll element into view    xpath://*[@name="MobilePhone"]
    capture page screenshot
    mouse down    xpath://*[@name="SaveEdit"]
    mouse up      xpath://*[@name="SaveEdit"]

    wait until page does not contain element     xpath://*[@name="SaveEdit"]    30s
    #${VAR}=    get text    xpath:(//*[@class="custom-truncate uiOutputText"])

Search Contact
    [Arguments]    ${VAR}
    click element    xpath:(//*[@data-key="search"])
    sleep    1s
    wait until element is enabled    (//*[@type="search"])[5]    50s
    input text   (//*[@type="search"])[5]    ${VAR}
    #click element    xpath://*[@title="Search"]
    sleep    10s
    #Wait Until Page Contains Element    xpath://*[@title="${VAR}"]    60s
    #click element       xpath:(//search_lightning-instant-result-item/div)[5]
    click element       xpath:(//mark[text()="Contacttest"])[1]

    capture page screenshot



Choose new account Retailer K&B
    wait until element is visible    xpath://*[text()="Accounts"]/parent::a    60s
    mouse down    xpath://*[text()="Accounts"]/parent::a
    mouse up    xpath://*[text()="Accounts"]/parent::a
    ${CountProducts1}=    get element count    xpath://*[text()="Account Name"]
    capture page screenshot
    IF    ${CountProducts1}==0
    mouse down    xpath://*[text()="Accounts"]/parent::a
    mouse up    xpath://*[text()="Accounts"]/parent::a
    END
    wait until page contains element    xpath://*[@title="New"]    30s
    mouse down    xpath://*[@title="New"]
    mouse up    xpath://*[@title="New"]
    ${CountProducts1}=    get element count    xpath://*[text()="Select a record type"]
    capture page screenshot

    IF    ${CountProducts1}==0
    mouse down    xpath://*[@title="New"]
    mouse up    xpath://*[@title="New"]
    END

    wait until page contains element    xpath://*[text()="Select a record type"]    60s

    scroll element into view    xpath://*[text()="K&B"]
    ${CountProducts1}=    get element count    xpath://*[text()="K&B"]
    capture page screenshot

    IF    ${CountProducts1}==0
    scroll element into view    xpath://*[text()="K&B"]
    END

    click element    xpath://*[text()="K&B"]
    click element    xpath://*[text()="Next"]
    wait until page contains element    xpath://*[text()="Account Record Type"]    60s
    capture page screenshot





Choose new account Fabricator
    wait until element is visible    xpath://*[text()="Accounts"]/parent::a    60s
    mouse down    xpath://*[text()="Accounts"]/parent::a
    mouse up    xpath://*[text()="Accounts"]/parent::a
    ${CountProducts1}=    get element count    xpath://*[text()="Account Name"]
    capture page screenshot
    IF    ${CountProducts1}==0
    mouse down    xpath://*[text()="Accounts"]/parent::a
    mouse up    xpath://*[text()="Accounts"]/parent::a
    END
    wait until page contains element    xpath://*[@title="New"]    30s
    mouse down    xpath://*[@title="New"]
    mouse up    xpath://*[@title="New"]
    ${CountProducts1}=    get element count    xpath://*[text()="Select a record type"]
    capture page screenshot

    IF    ${CountProducts1}==0
    mouse down    xpath://*[@title="New"]
    mouse up    xpath://*[@title="New"]
    END

    wait until page contains element    xpath://*[text()="Select a record type"]    60s

    scroll element into view    xpath://*[text()="Fabricator"]
    ${CountProducts1}=    get element count    xpath://*[text()="Fabricator"]
    capture page screenshot

    IF    ${CountProducts1}==0
    scroll element into view    xpath://*[text()="Fabricator"]
    END

    click element    xpath://*[text()="Fabricator"]
    click element    xpath://*[text()="Next"]
    wait until page contains element    xpath://*[text()="Account Record Type"]    60s
    capture page screenshot