require 'rails_helper'
require 'spec_helper'

describe 'edit user profile' do

	before do

		visit '/users/sign_up'

		fill_in("Username", :with => "test3")
		fill_in("Password", :with => "Test123!")
		fill_in("Password confirmation", :with => "Test123!")
		select("1", :from => "user[birthday(3i)]")
		select("January", :from => "user[birthday(2i)]")
		select("1990", :from => "user[birthday(1i)]")
		fill_in("Email", :with => "test@tester2.test")
	  	expect {click_button 'Sign Up' }.to change(User, :count).by(1)

	  	visit '/users/edit'

	end

	describe "Should have These fields" do
		it "Should have content 'first name'" do
			expect(page).to have_selector("label", text: "First name")
			fill_in("First name", :with => 'foo')
			fill_in("Current password", :with => 'Test123!')
			click_button('Update')
			visit 'profile'
			page.has_table?("foo")
		end

		it "Should have content 'Last name'" do
			expect(page).to have_selector("label", text: "Last name")
			fill_in("Last name", :with => 'bar')
			fill_in("Current password", :with => 'Test123!')
			click_button('Update')
			visit 'profile'
			page.has_table?("bar")
		end

		it "Should have content 'Username'" do
			expect(page).to have_selector("label", text: "Username")
			visit 'profile'
			page.has_table?("test3")
		end

		it "Should have content 'Age'" do
			expect(page).to have_selector("label", text: "Age")
			select("1", :from => "user[birthday(3i)]")
			select("January", :from => "user[birthday(2i)]")
			select("1980", :from => "user[birthday(1i)]")
			fill_in("Current password", :with => 'Test123!')
			click_button('Update')
			visit 'profile'
			page.has_table?("35")
		end

		it "Should have content 'Country Code'" do
			expect(page).to have_selector("label", text: "Country code")
			select("United States", :from => "Country code")
			fill_in("Current password", :with => 'Test123!')
			click_button('Update')
			visit 'profile'
			page.has_table?("US")
		end

		it "Should have content 'Sex'" do
			expect(page).to have_selector("label", text: "Sex")
			select("Female", :from => "Sex")
			fill_in("Current password", :with => 'Test123!')
			click_button('Update')
			visit 'profile'
			page.has_table?("Female")
		end

		it "Should have content 'First language'" do
			expect(page).to have_selector("label", text: "First Language")
			select("English", :from => "user_language_first")
			fill_in("Current password", :with => 'Test123!')
			click_button('Update')
			visit 'profile'
			page.has_table?("English")
		end

		it "Should have content 'Second language'" do
			expect(page).to have_selector("label", text: "Second Language")
			select("German", :from => "user_language_second")
			fill_in("Current password", :with => 'Test123!')
			click_button('Update')
			visit 'profile'
			page.has_table?("German")
		end
	end
end