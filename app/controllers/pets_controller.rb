class PetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_pet, only: [:show, :archive]

  # GET /users/:user_id/pets
  def index
    if params[:archived] == "true"
      @pets = current_user.pets.unscoped.where(user: current_user, archived: true)
      @title = "Heart Gallery"
    else
      @pets = @user.pets
      @title = "Your Pets!"
    end
  end

  # GET /users/:user_id/pets/:id
  def show
    @log = Log.new
    # fetch the user's other pets except the current one, to show in the circles
    @other_pets = @user.pets.where.not(id: @pet.id)
  end

  # GET /users/:user_id/pets/new
  def new
    @pet = Pet.new
  end

  # POST /users/:user_id/pets
  def create
    @pet = Pet.new(pet_params)
    @pet.user = @user

    if @pet.save
      redirect_to [@user, @pet], notice: 'Pet was successfully registered!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def archive
    @pet.archive!
    redirect_to user_pets_path(current_user, @pets)
  end

  def archived
    @archived_pets = current_user.pets.unscoped.where(archived: true)
  end

  def unarchive
    @pets = Pet.unscoped.find(params[:id])
    @pets.update(archived: false)
    redirect_to user_pets_path(current_user, archived: true), notice: "#{@pets.name} was restored."
  end

  private

  def set_user
    @user = User.find(params[:user_id])

    if @user != current_user
      redirect_to root_path, alert: "Unauthorized access."
    end
  end

  def set_pet
    @pet = @user.pets.unscoped.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to user_pets_path(@user), alert: "Pet not found or access denied."
  end

  def destroy
      @pet = @user.pets.find(params[:id])
      @pet.destroy

  end

  def pet_params
    params.require(:pet).permit(
      :name, :dob, :species, :breed, :microchip,
      :weight, :current_meds, :vacc_status, :notes,
      :insurance, :fixed, :gender, :photo
    )
  end
end
