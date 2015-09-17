require 'rails_helper'

RSpec.describe "groups/edit", type: :view do
  before(:each) do
    @group = assign(:group, Group.create!(
      :title => "MyString",
      :description => "MyText",
      :user => nil,
      :limitation => 1
    ))
  end

  it "renders the edit group form" do
    render

    assert_select "form[action=?][method=?]", group_path(@group), "post" do

      assert_select "input#group_title[name=?]", "group[title]"

      assert_select "textarea#group_description[name=?]", "group[description]"

      assert_select "input#group_user_id[name=?]", "group[user_id]"

      assert_select "input#group_limitation[name=?]", "group[limitation]"
    end
  end
end
