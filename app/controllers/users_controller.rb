class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new_registration, :registration_save, :success_registration]
  load_and_authorize_resource except: [:new_registration, :registration_save, :success_registration]

  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :set_profiles_for_select, only: [:edit, :new, :create]
  # before_action :verify_user_registration, except: [:complete_registration, :registration_save]

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

  def new_registration
    @user = User.new
  end

  def success_registration
  end

  def edit_registration
    @user = User.find(current_user.id)
  end

  def registration_save
    @user = User.new(registers_user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to success_registration_users_path, notice: 'Cadastro concluído com sucesso!'  }
      else
        format.html { render "new_registration" }
      end
    end
  end

  def registration_update
    @user = User.find(current_user.id)
    respond_to do |format|
      if @user.update(registers_user_params)
        format.html { render "home/index", notice: 'Cadastro atualizado com sucesso!'  }
      else
        format.html { render "edit_registration" }
      end
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
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

  def set_profiles_for_select
    @profiles = Profile.all.select(:name, :id).map { |k, v| [k.name, k.id] }
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:email,
                                 :encrypted_password,
                                 person_attributes: [:name,
                                          :surname,
                                          :registration,
                                          :cpf,
                                          :cellphone, :date_of_birth],
                                 :profile_ids => [])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def registers_user_params
    params.require(:user).permit(:email,
                                 :encrypted_password,
                                 person_attributes: [:name,
                                          :surname,
                                          :registration,
                                          :cpf,
                                          :cellphone, :date_of_birth])
  end
end
