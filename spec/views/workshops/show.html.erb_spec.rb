require 'spec_helper'

describe "workshops/show" do
  before(:each) do
    @workshop = assign(:workshop, stub_model(Workshop,
      :name => "Name",
      :description => "MyText",
      :venue => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
  end
end
