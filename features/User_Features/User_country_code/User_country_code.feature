Feature: Save the country code of the user
	In order to get data about the user
	And for advertisment purposes
	I want Cairai to be a customize experiance for our users

	Scenario: Get country code of user
		Given User is logged in
		And on profile page
		When User picks courntry
		Then Save country in user database