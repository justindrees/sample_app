require 'spec_helper'

describe "Authentication" do

	subject { page }

	describe "GET /authentication_pages" do
		it "works!" do
	    	# Run the generator again with the --webrat flag if you want to use webrat methods/matchers
	    	get signin_path
	    	response.status.should be(200)
    	end
    end

    describe "signin page" do
		before { visit signin_path }

		it { should have_content('Logga in') }
		it { should have_title('Logga in') }
	end

	describe "signin" do
		before { visit signin_path }

		describe "with invalid information" do
			before { click_button "Logga in" }

			it { should have_title('Logga in') }
			it { should have_selector('div.alert.alert-error') }

			describe "after visiting another page" do
				before { click_link "Hem" }
				it { should_not have_selector('div.alert.alert-error') }
			end
		end

		describe "with valid information" do
			let(:user) { FactoryGirl.create(:user) }
			before do
				fill_in "Email",		with: user.email.upcase
				fill_in "Password",		with: user.password
				click_button "Logga in"
			end

			it { should have_title(user.name) }
			it { should have_link('Profile',		href: user_path(user)) }
			it { should have_link('Logga ut',		href: signout_path) }
			it { should_not have_link('Logga in'),	href: signin_path }
			
			describe "followed by signout" do
				before { click_link "Logga ut" }
				it { should have_link('Logga in') }
			end
		end
	end
end
