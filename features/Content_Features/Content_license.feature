Feature: Give the user a variety of license to put content over 
	In order to allow the user to have more choices in his content path
	And give more to the public domain
	I want Cairai to be known as a charitable company

	Scenario: User chooses Cairai license
		Given user is logged in
		And user is uploading content
		When user chooses CaIriai license
		Then CaIrai license will be said in description
		And ads are allowed to be displayed
		And downloading is turned off

	Scenario: User chooses Creative Commons Attribution
		Given User is logged in
		And user is uploading content
		When user chooses Creative Commons Attribution
		Then Creative Commons Attribution will be said in description
		And ads are allowed to be displayed

	Scenario: User chooses Creative Commons Attribution-ShareAlike
		Given User is logged in
		And user is uploading content
		When user chooses Creative Commons Attribution-ShareAlike
		Then Creative Commons Attribution-ShareAlike will be said in description
		And ads are allowed to be displayed

	Scenario: User chooses Creative Commons Attribution-NoDerivs
		Given User is logged in
		And user is uploading content
		When user chooses Creative Commons Attribution-NoDerivs
		Then Creative Commons Attribution will be said in description
		And ads are allowed to be displayed

	Scenario: User chooses Creative Commons Attribution-NonCommercial
		Given User is logged in
		And user is uploading content
		When user chooses Creative Commons Attribution-NonCommercial
		Then Creative Commons Attribution will be said in description
		And ads are NOT allowed to be displayed

	Scenario: User chooses Creative Commons Attribution-NonCommercial-ShareAlike
		Given User is logged in
		And user is uploading content
		When user chooses Creative Commons Attribution-NonCommercial-ShareAlike
		Then Creative Commons Attribution will be said in description
		And ads are NOT allowed to be displayed

	Scenario: User chooses Creative Commons Attribution-NonCommercial-NoDerivs
		Given User is logged in
		And user is uploading content
		When user chooses Creative Commons Attribution-NonCommercial-NoDerivs
		Then Creative Commons Attribution will be said in description
		And ads are NOT allowed to be displayed