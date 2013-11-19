require 'spec_helper'

describe "workshops/new" do
  before(:each) do
    assign(:workshop, stub_model(Workshop,
      :name => "MyString",
      :description => "MyText",
      :venue => "MyText"
    ).as_new_record)
  end

  it "renders new workshop form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", workshops_path, "post" do
      assert_select "input#workshop_name[name=?]", "workshop[name]"
      assert_select "textarea#workshop_description[name=?]", "workshop[description]"
      assert_select "textarea#workshop_venue[name=?]", "workshop[venue]"
    end
  end
end
