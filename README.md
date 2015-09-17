== README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


Please feel free to use a different markup language if you do not plan to run
rake doc:app

# Building notes:

## initial command
rails new studygroup -d postgresql
cd studygroup
git init
git add .
git commit -m 'init commit'

## add required gems to Gemfile
bundle
git add .
git commit -m 'add required gems'

## add a branch to add User
git checkout -b add_user
rails g devise:install
rails g devise:views
rails g devise User
git add .
git commit -m 'add user'
git push origin add_user

## add a branch to add Group
git checkout -b add_group
rails g scaffold group title description:text user:references:index limitation:integer
git add .
git commit -m 'add group information'
git push origin add_group

## build group user relationship
git checkout -b build_group_user_relationship
rails g model group_user group_id:integer user_id:integer
# rails g model group_user group:references user:references
# modify user.rb
...
 has_many :groups
 has_many :posts

 has_many :group_users
 has_many :participated_groups, through: :group_users, source: :group
...

# modify group_users
...
  belongs_to :user
  belongs_to :group

  def join!(group)
    participated_groups << group
  end

  def quit!(group)
    participated_groups.delete(group)
  end

  def is_member_of?(group)
    participated_groups.include?(group)
  end
...

# modify group.rb
...
  has_many :group_users
  has_many :members, through: :group_users, source: :user
...

# modify groups_conftroller.rb
...
  def join
    @group = Group.find(params[:id])

    if !current_user.is_member_of?(@group)
      current_user.join!(@group)
      flash[:notice] = "報名成功！"
    else
      flash[:warning] = "你已經報名！"
    end

    redirect_to group_path(@group)
  end

  def quit
    @group = Group.find(params[:id])

    if current_user.is_member_of?(@group)
      current_user.quit!(@group)
      flash[:alert] = "已取消報名！"
    else
      flash[:warning] = "尚未報名！"
    end

    redirect_to group_path(@group)
  end
...

# modify show.haml
...
- if current_user.present?
  - if current_user.is_member_of?(@group)
    = link_to("Quit Group", quit_group_path(@group), method: :post, class: "btn btn-danger")
  - else
    = link_to("Join Group", join_group_path(@group), method: :post, class: "btn btn-info")
...

#route.rb
...
  resources :groups do
    member do
      post :join
      post :quit
    end
  end
...