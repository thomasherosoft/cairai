Feature: Input and save user sex
	In order to get data about the user
	And for advertisement purposes
	I want Cairai to be a custom experience tailored to our users

	Scenario: Input the sex of the user
		Given User is on profile page
		When user selects sex
		Then user can pick the sex. Including male
		And Female
		And Androgyny
		And save that information to the user database