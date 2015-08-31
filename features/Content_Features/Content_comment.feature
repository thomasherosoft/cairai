Feature: Add comments and commet features to content
	In order to make cairai a more social experiance
	And Give providers some feedback for their work
	I want to make cairai into a social web application

	Scenario: User comment fail: Post while not logged in
		Given User is not logged in
		And user is on content
		When user clicks post content
		Then show error that user isn't logged in
		And redirect user to signup form

	Scenario: User comment fail: Post while logged in but length is under 20 characters
		Given User is logged in
		And user is on content
		When user clicks post comment
		And comment is less than 20 characters
		Then show error that user isn't logged in
		And redirect user to signup form

	Scenario: User comment sucess: User comment while logged in
		Given User is logged in
		And user is on content
		When user clicks post content
		And comment is 20 characters or more than
		Then Comnent posts

	Scenario: Thumbs up/down fail: user not logged in
		Given user is not logged in
		And user is on content
		When user thumbs up or down comment
		Then show error that user isn't logged in
		And redirect user to signup form

	Scenario: Thumbs up/down fail: User thumbs up or down his own comment
		Given user is logged in
		And user is on content
		When user thumbs up or down users own comment
		Then show error that user cant thumbs up/thumbs down his or her comment

	Scenario: Thumbs up/down pass: User thumbs up or down different comment
		Given user is logged in
		And user is on content
		When user thumbs up or down a different users comment
		Then apply thumbs up or down

	Scenario: Tips cairai coins
		Given user is logged in
		And user is on content
		And There is a comment
		When user clicks on tip
		Then there is a box that asks how many coins
		And there is a limit of ten coins
		And One coin will be removed inorder to keep balance