require 'rails_helper'

RSpec.describe "groups/index", type: :view do
  before(:each) do
    assign(:groups, [
      Group.create!(
        :title => "Title",
        :description => "MyText",
        :user => nil,
        :limitation => 1
      ),
      Group.create!(
        :title => "Title",
        :description => "MyText",
        :user => nil,
        :limitation => 1
      )
    ])
  end

  it "renders a list of groups" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
