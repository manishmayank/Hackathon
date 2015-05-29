class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  require 'digest'

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    user = User.where(:username => params[:username])
    success = true
    if (user)
      success = false
    else
      success = true
      md5_hash = Digest::SHA256.digest params[:username]
      user = User.create(username:params[:username], email:params[:email], auth_token:md5_hash, password:params[:password], password_confirmation:params[:password])
    end

    respond_to do |format|
        if success
          # format.html { redirect_to @user, notice: 'User was successfully created.' }
          format.json { render json: {succes:true, auth_token:md5_hash} }
        else
          # format.html { render :new }
          format.json { render json: {succes:false} }
        end
    end
  end

  def logout
    user = User.where(:id => params[:user_id], :auth_token => params[:auth_token])
    if(user)
      user.auth_token = ""
      user.save
      respond_to do |format|
        format.json { render json: {succes:true} }
      end
    else
      respond_to do |format|
        format.json { render json: {succes:false} }
    end
  end

  def login
    user = User.where(:username => params[:username], :password => params[:password])
    succes = true
    if(User)
      md5_hash = Digest::SHA256.digest params[:username]
      user.auth_token = md5_hash
      user.save
    else
      succes = false
    end

    respond_to do |format|
        if success
          # format.html { redirect_to @user, notice: 'User was successfully created.' }
          format.json { render json: {succes:true, auth_token:md5_hash} }
        else
          # format.html { render :new }
          format.json { render json: {succes:false} }
        end
    end

  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params[:user]
    end
end
