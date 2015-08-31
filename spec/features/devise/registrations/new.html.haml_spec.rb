require 'rails_helper'
require 'spec_helper'

describe "devise sign up" do

	before { visit '/users/sign_up'}
	describe "Sign up content" do
	  it "Should have the content 'Sign up'" do
	  	expect(page).to have_content("Sign up")
	  end
	end

	  describe "invalid information" do
	  	it "should be invalid: No information" do
	  		expect {click_button 'Sign Up' }.not_to change(User, :count)
	  	end

	  	it "should be invalid: Only first name" do
	  		fill_in("First Name", :with => 'foo')
	  		expect {click_button 'Sign Up' }.not_to change(User, :count)
	  	end

	  	it "should be invalid: Only first name" do
	  		fill_in("First Name", :with => 'foo')
	  		fill_in("Last Name", :with => 'bar')
	  		expect {click_button 'Sign Up' }.not_to change(User, :count)
	  	end

	  	end

	  describe "Email tests" do
	  	before do
	  		fill_in("Username", :with => "test3")
	  		fill_in("Password", :with => "Test123!")
	  		fill_in("Password confirmation", :with => "Test123!")
	  		select("1", :from => "user[birthday(3i)]")
	  		select("January", :from => "user[birthday(2i)]")
	  		select("1990", :from => "user[birthday(1i)]")
	  	end

	  	it "should be invalid: no dot" do
	  		fill_in("Email", :with => "test@testcom")
	  		expect {click_button 'Sign Up' }.not_to change(User, :count)
	  	end

	  	it "should be invalid: no at" do
	  		fill_in("Email", :with => "testtest.com")
	  		expect {click_button 'Sign Up' }.not_to change(User, :count)
	  	end

	  	it "should be invalid: no front text" do
	  		fill_in("Email", :with => "@test.com")
	  		expect {click_button 'Sign Up' }.not_to change(User, :count)
	  	end

	  	it "should be valid" do
	  		fill_in("Email", :with => "test@tester2.test")
	  		expect {click_button 'Sign Up' }.to change(User, :count).by(1)
	  	end
	end

	describe "Password tests" do
	  	before do
	  		fill_in("Username", :with => "test3")
	  		fill_in("Email", :with => "test@tester2.test")
	  		select("1", :from => "user[birthday(3i)]")
	  		select("January", :from => "user[birthday(2i)]")
	  		select("1990", :from => "user[birthday(1i)]")
	  	end

	  	it "should be invalid: not 8 characters" do
	  		fill_in("Password", :with => "Test")
	  		fill_in("Password confirmation", :with => "Test")
	  		expect {click_button 'Sign Up' }.not_to change(User, :count)
	  	end

	  	it "should be invalid: 8 characters but no capital" do
	  		fill_in("Password", :with => "test1234")
	  		fill_in("Password confirmation", :with => "test1234")
	  		expect {click_button 'Sign Up' }.not_to change(User, :count)
	  	end

	  	it "should be invalid: 8 characters, with capital but no special character" do
	  		fill_in("Password", :with => "Test1234")
	  		fill_in("Password confirmation", :with => "Test1234")
	  		expect {click_button 'Sign Up' }.not_to change(User, :count)
	  	end

	  	it "should be invalid: password and password confirmation don't match" do
	  		fill_in("Password", :with => "Test1234")
	  		fill_in("Password confirmation", :with => "Test5678")
	  		expect {click_button 'Sign Up' }.not_to change(User, :count)
	  	end

	  	it "should be valid: 8 characters, with capital with special character" do
	  		fill_in("Password", :with => "Test123!")
	  		fill_in("Password confirmation", :with => "Test123!")
	  		expect {click_button 'Sign Up' }.to change(User, :count).by(1)
	  		expect(page).to have_content("Comics")
	  	end
	end
end