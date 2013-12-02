require 'spec_helper'

describe "workshops/index" do
  before(:each) do
    assign(:workshops, [
      stub_model(Workshop,
        :name => "Name",
        :description => "MyText",
        :venue => "MyText"
      ),
      stub_model(Workshop,
        :name => "Name",
        :description => "MyText",
        :venue => "MyText"
      )
    ])
  end

  it "renders a list of workshops" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
