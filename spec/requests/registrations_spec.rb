require 'spec_helper'

describe "User pages" do
	subject { page }

	describe "Registration page" do
		before { visit registrations_path } #DO SOMETHING BEFORE EVERY TEST!

		it { should have_content('New registraion') }
	end
end


