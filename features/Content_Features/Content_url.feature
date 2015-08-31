Feature: Allow users to have their own url
	In order to increase the personal experiance of our users
	I want Cairai to be a personal experiance for our users

	Scenario: cairai in the url
		Given user is logged in on cairai
		And on the upload content link
		When User clicks on url
		Then there is place holder text that says "https://www.cairai.com/"
		And the text isn't deletable or editable