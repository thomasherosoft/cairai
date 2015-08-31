Feature: Put an age restriction on content that is adult
	In order to block content that is inappropriate for children
	And block content for people who aren't logged in
	I want to make sure Cairai is a safe environment for everyone of all ages

	Scenario: Content show Pass: User Not logged in, content is rated Everyone
		Given User is not logged in 
		And content is rated all ages
		When User clicks link to show content
		Then the content will show

	Scenario: Content show fail: User Not logged in, Content is rated 13 and up
		Given User is not logged in
		And content is rated 13 and up
		When user clicks link to show content
		Then the content will not show
		And Prompt the user to login

	Scenario: Content show fail: User not logged in, Content is rated 17 and up
		Given User is not logged in
		And content is rated 17 and up
		When user clicks link to show content
		Then the content will not show
		And prompt the user to login

	Scenario: Content show pass: User logged in, content is rated all ages
		Given user is logged in
		And content is rated everyone
		Then the content will show

	Scenario: Content show fail: User is logged in, content is rated 13 and up
		Given user is logged in
		And age is 12 years old
		And Content is rated 13 and up
		When user clicks link to show content
		Then the content will not show
		And Tell user the content is only for people who are 13 and older

	Scenario: Content show pass: User is logged in, content is rated 13 and up
		Given user is logged in
		And age is 13 years old
		And content is rated 13 and up
		When user clicks link to show content
		Then the content will show

	Scenario: Content show fail: USer is logged in, content is rated 17 and up
		Given user is logged in
		And age is 16 years old
		And Content is rated 17 and up
		When user clicks link to show content
		Then the content will not show
		And Tell user the content is only for people who are 17 and older

	Scenario: Content show pass: User is logged in, content is rated 17 and up
		Given user is logged in
		And age is 17 years old
		And content is rated 17 and up
		When user clicks link to show content