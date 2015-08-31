Feature: Allow the provider to see and buy storage
	In order to help fund the growth of cairai
	I want to turn this into a profitable venture

	Scenario: upload sucess: User has enough storage
		Given user is logged in
		And user is on uploading content
		And user has enough storage
		When user uploads pdf
		Then pdf is stored

	Scenario: upload fails: User does not have enough storage
		Given User is logged in
		And user is on uploading content
		And user does not have enough storage
		When user uploads pdf
		Then pdf is not stored in pdf
		And error message tells user that there is not enough room

	Scenario: User doesn't have enough coins
		Given user is logged in
		And user is on uploading content
		And user does not have 100 coins
		When user clicks add space button
		Then a prompt pulls up asking him to add coins
		And takes him to the payment place

	Scenario: User has 100 coins
		Given user is logged in
		And user is on upload content
		And user has 100 coins
		When user clicks add space button
		Then one hundred coins is taken out
		And User is given 1gb of space

	Scenario: User has 2500 coins
		Given user is logged in
		And user is on upload content
		And user has 2500 coins
		When user clicks ad spece button
		And user clickss 30gb option
		Then 2500 coins is taken out
		And user is given 1gb of space