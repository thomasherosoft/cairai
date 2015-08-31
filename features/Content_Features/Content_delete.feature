Feature: Add a delete button that will remove the comic from the app.
	In order to remove the content that the provider doesn't want on his/her Account
	I want to help clean up someones channel

	Scenario: Delete content from an account
		Given User is on his account
		And on the feed page
		When user deletes content
		Then content is deleted
		And all comments are deleted
		And User does not get storage back