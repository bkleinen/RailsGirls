require 'test_helper'

class RegistrationsControllerTest < ActionController::TestCase
  setup do
    @registration = registrations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:registrations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create registration" do
    assert_difference('Registration.count') do
      post :create, registration: { email: @registration.email, firstname: @registration.firstname, lastname: @registration.lastname, motivation: @registration.motivation, os: @registration.os, programming: @registration.programming, railsexperience: @registration.railsexperience, specialdiat: @registration.specialdiat, twitter: @registration.twitter }
    end

    assert_redirected_to registration_path(assigns(:registration))
  end

  test "should show registration" do
    get :show, id: @registration
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @registration
    assert_response :success
  end

  test "should update registration" do
    patch :update, id: @registration, registration: { email: @registration.email, firstname: @registration.firstname, lastname: @registration.lastname, motivation: @registration.motivation, os: @registration.os, programming: @registration.programming, railsexperience: @registration.railsexperience, specialdiat: @registration.specialdiat, twitter: @registration.twitter }
    assert_redirected_to registration_path(assigns(:registration))
  end

  test "should destroy registration" do
    assert_difference('Registration.count', -1) do
      delete :destroy, id: @registration
    end

    assert_redirected_to registrations_path
  end
end
