require 'spec_helper'

describe UsersController do

  describe "GET # show" do
    it "assigns the requested user into @user" do
      user = FactoryGirl.create(:user)
      get :show, id: user
      assigns(:user).should == user
    end

    it "renders the :show view" do
      user = FactoryGirl.create(:user)
      get :show, id: user
      response.should render_template :show
    end
  end

  describe "GET # new" do
    it "assigns the new user into @user" do
      get :new
      assigns(:user).class.should == User
    end

    it "renders the :new view" do
      get :new
      response.should render_template :new
    end
  end

  describe "POST # create" do
    context "with valid attributes" do
      it "saves the new user into the database" do
        expect { post :create, user: FactoryGirl.attributes_for(:user)}.to change(User, :count).by(1)
      end
    end

    context "with invalid attributes" do
      it "does not save the user into the database" do
        expect { post :create, user: FactoryGirl.attributes_for(:invalid_user)}.to_not change(User, :count)
      end

      it "re-render the :new view" do
        post :create, user: FactoryGirl.attributes_for(:invalid_user)
        response.should render_template :new
      end
    end
  end
end