require 'spec_helper'

describe "workshops/edit" do
  before(:each) do
    @workshop = assign(:workshop, stub_model(Workshop,
      :name => "MyString",
      :description => "MyText",
      :venue => "MyText"
    ))
  end

  it "renders the edit workshop form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", workshop_path(@workshop), "post" do
      assert_select "input#workshop_name[name=?]", "workshop[name]"
      assert_select "textarea#workshop_description[name=?]", "workshop[description]"
      assert_select "textarea#workshop_venue[name=?]", "workshop[venue]"
    end
  end
end
