Feature: Get and Verify the Users Email
	In order to send emails to user
	And Ensure user is a real person, not a spammer 
	And other aspects of Cairai.
	I want to increase user return rate and provide a community free from Spam (one way of helping it)

	# word key
	# User: Anybody externally who uses Cairai 
	# Account: A group of different content (books, comics) that falls under a user or users (name of account is a users user name)
	# Provider: Someone or someones who runs an account
	# Moderator: Someone who has some abilities under an account (edit tags, remove comments, add information to FAQ)
	# Subscriber: Someone who is subscribed to an account
	# Premium Subscriber: Someone who is subscribed to an account and pays. Gets privileges such as highlighted user name, access to videos no one else sees, and more
	# Friend: Someone who is subscribed to another user

	# Email & Email verification scenarios 
	Scenario: Get the Users Email Address
		Given I have a text box for the users email address
		When I sign up the User
		Then The user should be able to input email address
		And Email address will be saved in the database
		And We can send emails to the end user

	Scenario: Verify link sent to user to confirm email
		Given User just signed up
		When User clicked the submit button
		Then The user will receive an email to verify the existence of email address

	Scenario: Warning ribbon telling user to verify email
		Given User is signed in
		And email is not verified
		When User is on the site
		Then Display a warning telling the user "Verify Email Address in x Days. Resend Email"
		And Resend email will resend the email to the user

	Scenario: Verify Fail: Delete user when user does not verify email
		Given User hasn't verified the email within fourteen days
		When when user signed up
		Then User account will be deleted
		And Deletion notice email will be sent out to user
		And Within deletion notice will be a link to sign back up

	Scenario:Verify success: Email user when user first logs in (Welcome email)
		Given User just signed up and is verified
		When user clicked the verify email link
		Then user will receive a welcome email with name
		And profile link

	Scenario: Get Email user preferences
		Given I have a link under email that says preference
		When users are at the profile page
		And They click the link under email that says preference
		Then The user can change the preference when the user gets emails. They are when user comments
		And when Account releases content
		And Account of the day
		And When blog is updated 