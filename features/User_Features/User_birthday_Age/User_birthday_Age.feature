Feature: Get the date the user is born and derive the age
	In order to get data for age restriction feature (under content folder)
	And birthday email
	I want to make sure kids don't see adult content and provide a personal feel to Cairai

	Scenario: Get the birth-date of the user
		Given  User is signing up
		When User inputs the day of birth
		And The Month of birth
		And the year of birth
		Then Save the date in the database

	Scenario: Send birthday email
		Given Users exist and entered in birthday
		When The day and month of birth coincides with the day
		Then Send an email saying happy birthday
		And Reward the user ten coins