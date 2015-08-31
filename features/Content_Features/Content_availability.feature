Feature: Allow provider to select the avaliblity of the content
	In order to let content provides schedule out their content
	And Give them time to update the settings
	And reward premium members with early acess, exlusive access

	Scenario: Provider selects live
		Given user is uploading content
		And USer selects public
		When user saves settings
		Then video is published to everyone
		And Subscribers and premium subscribers get notified

	Scenario: Provider selects schedule
		Given user is uploading content
		And user selects schedule
		And a calender pops up
		When user selects date, hour and minute
		And user saves settings
		Then content wont become live until date

	Scenario: Provider selects Live Premium 
		Given user is uploading contnet
		And user selects Live Premium 
		When user saves settings
		Then Content is published to premium members only
		And Premium subscribers get notified

	Scenario: Provider selects Schedule Premium
		Given user is uploading content
		And user selects schdule premium
		And a calender pops up
		When user selects date, hour and minute
		And user saves settings
		Then content wont become live premium until date

	Scenario: Provider slects Premium then live
		Given user is uploading content
		And user selects premium then line
		And a calder pops up
		When user selects date,  houour minte
		And user saves settings
		Then Content is live for premium
		And premium members get notified
		And once date hits then is live for everyone
		And Everyone get's notified