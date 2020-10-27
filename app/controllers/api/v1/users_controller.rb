require 'bcrypt'

class Api::V1::UsersController < ApplicationController
  before_action :authenticate_request!, except: [:create, :login]
  before_action :load_current_user!, only: [:show, :update, :destroy]

  def login
    user = User.find_by(email: login_params[:email].to_s.downcase)

    if user&.authenticate(login_params[:password])
      auth_token = JsonWebToken.encode(user_id: user.id)
      render json: { auth_token: auth_token }, status: :ok
    else
      render json: { error: 'Invalid username/password' }, status: :unauthorized
    end
  end

  def create
    @user = User.new(user_params)
    @user.email = @user.email.downcase

    if @user.save && @user.authenticate(user_params[:password])
      auth_token = JsonWebToken.encode(user_id: @user.id)
      render json: { auth_token: auth_token }, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
  def login_params
    params.require(:user).permit(:email, :password)
  end
end
