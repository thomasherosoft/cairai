Feature: Get and recover user password
	In order to authenticate the user
	I want to identify the user

	Scenario: Password fail: Password with just 6 characters
		Given User is signing up
		When User gives password "failed"
		Then User gets error
		And Password is not saved

	Scenario: Password fail: Password with 8 characters
		Given User is signing up
		When User gives password "failedaa"
		Then User gets error
		And Password is not saved

	Scenario: Password fail: Password with 7 characters, one number
		Given User is signing up
		When User gives password "faileda1"
		Then User gets error
		And Password is not saved

	Scenario: Password success: Password with 6 characters, one number, one special character
		Given User is signing up
		When User gives password "failed!1"
		Then password is saved