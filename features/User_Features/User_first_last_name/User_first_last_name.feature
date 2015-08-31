Feature: Get users first and last name
	In order to display it 
	And make it easier for other users to find and friend
	I want to make it easier for the community to find each other 
	And Make the app feel more personalized

	Scenario: Get users first and last name
		Given User is on the login page
		When User inputs first name into input box
		And User inputs Last name into input box
		And User clicks sign up
		Then First and last name is saved into the database under user

	Scenario: Display the users first and last name on the top menu bar
		Given User is at the home page
		And User is logged in 
		When User has a first and last name
		Then Users first and last name is displayed next to their picture

	Scenario: Displays users first and last name along with username in comment
		Given User just posted a comment 
		And User is logged in
		And User has a first and last name under account
		When Another user sees his comment
		Then That user will see first 
		And last name along with username on the navigation

	Scenario: Search for users using their first and last name
		Given User 'Abigale Abby' wants to find 'bob bobby'
		And 'Abigale Abby' has an account
		And 'bob bobby' has an account
		When 'Abigale Abby' searches for 'bob bobby'
		Then 'bob bobby' should pop up