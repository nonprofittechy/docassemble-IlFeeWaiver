@interviews_start
Feature: The interviews run through the main paths of the fee waiver

Those scenarios are:
1. Gets benefits
2. No benefits but low income
3. No benefits and high income

These tests are made to work with the ALKiln testing framework, an automated testing framework made under the Document Assembly Line Project.

See ALKiln's docs: https://suffolklitlab.github.io/docassemble-AssemblyLine-documentation/docs/automated_integrated_testing

@ilfeewaiver @start @fast @fw0
Scenario: IL_fee_waiver.yml just starts
  Given I start the interview at "IL_fee_waiver.yml"

@ilfeewaiver @benefits @fw1
Scenario: Gets benefits
  Given I start the interview at "IL_fee_waiver.yml"
  And I get to the question id "get-docs-screen" with this data:
    | var | value | trigger |
    | accept | True | |
    | filing_basis | filing_self | |
    | user_benefits["TA"] | True | |
    | users[0].name.first | Bob | |
    | users[0].name.last | Ma | |
    | user_ask_role | defendant | |
    | users.there_is_another | False | |
    | other_parties.there_are_any | False | |
    | trial_court_index | 1 | |
    | docket_number | 123456 | |
    | users[0].birth_year | 2000 | |
    | users[0].address.address | 123 Fake Street | |
    | users[0].address.city | Brighton | |
    | users[0].address.state | IL | |
    | users[0].address.zip | 02135 | |
    | x.phone_number | 1234567890 | users[0].has_email_address |
    | x.has_email_address | False | users[0].has_email_address |
    | signature_choice | add name | |
  Then I should see the phrase "Your forms are ready"

@ilfeewaiver @low-income @fw2
Scenario: No benefits, low income
  Given I start the interview at "IL_fee_waiver.yml"
  And I get to the question id "show_qualification_guess" with this data:
    | var | value | trigger |
    | accept | True | |
    | filing_basis | filing_self | |
    | user_benefits['None'] | True | |
    | user_applied_for_benefits['None'] | True | |
    | user_has_dependents | True | |
    | user_dependents_adults | 1 | |
    | user_dependents_children | 5 | |
    | user_income_none | True | |
    | user_annual_none | True | |
    | user_expense_rent | True | |
    | user_expense_rent_amount | 1000 | |
    | user_assets_none | True | |
  Then I see the phrase "You may qualify for a fee waiver"
  And I get to the question id "get-docs-screen" with this data:
    | users[0].name.first | Bob | |
    | users[0].name.last | Ma | |
    | user_ask_role | defendant | |
    | users.there_is_another | False | |
    | other_parties.there_are_any | False | |
    | trial_court_index | 1 | |
    | docket_number | 123456 | |
    | users[0].birth_year | 2000 | |
    | users[0].address.address | 123 Fake Street | |
    | users[0].address.city | Brighton | |
    | users[0].address.state | IL | |
    | users[0].address.zip | 02135 | |
    | x.phone_number | 1234567890 | users[0].has_email_address |
    | x.has_email_address | False | users[0].has_email_address |
    | signature_choice | add name | |
  Then I should see the phrase "Your forms are ready"