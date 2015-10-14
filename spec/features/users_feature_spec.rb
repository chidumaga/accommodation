require 'rails_helper'

feature "User can sign in and out" do
	context "user not signed in and on the homepage" do
		scenario "should see a 'sign in' link and a 'sign up' link" do
			visit('/')
			expect(page).to have_link('Sign in')
			expect(page).to have_link('Sign up')
		end

		scenario "should not see 'sign out' link" do
      		visit('/')
      		expect(page).not_to have_link('Sign out')
   		end
 	end

 	context "user signed in on the homepage" do
	    before do
	      visit('/')
	      click_link('Sign up')
	      fill_in('Email', with: 'test@example.com')
	      fill_in('Password', with: 'testtest')
	      fill_in('Password confirmation', with: 'testtest')
	      click_button('Sign up')
	    end

	    scenario "should see 'sign out' link" do
	      visit('/')
	      expect(page).to have_link('Sign out')
    	end

    	scenario "should not see a 'sign in' link and a 'sign up' link" do
	      visit('/')
	      expect(page).not_to have_link('Sign in')
	      expect(page).not_to have_link('Sign up')
   		end
    end
end

feature 'Users have a profile' do 
	scenario 'users can visit their profile page and see their information' do 
		sign_up
		visit '/'
		click_link 'Profile'
		expect(page).to have_content("test@example.com")
	end

	def sign_up(email="test@example.com", password="testtest")
		visit('/')
	    click_link('Sign up')
	    fill_in('Email', with: email)
	    fill_in('Password', with: password)
	    fill_in('Password confirmation', with: password)
	    click_button('Sign up')
	end
end