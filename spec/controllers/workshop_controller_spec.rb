require 'spec_helper'

describe WorkshopController do

  describe "GET 'name:string'" do
    it "returns http success" do
      get 'name:string'
      response.should be_success
    end
  end

  describe "GET 'description:text'" do
    it "returns http success" do
      get 'description:text'
      response.should be_success
    end
  end

  describe "GET 'date:date'" do
    it "returns http success" do
      get 'date:date'
      response.should be_success
    end
  end

  describe "GET 'venue:text'" do
    it "returns http success" do
      get 'venue:text'
      response.should be_success
    end
  end

end
