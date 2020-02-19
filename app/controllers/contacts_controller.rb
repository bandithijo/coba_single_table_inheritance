class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  # GET /contacts/new
  def new
    @user = User.find(params[:user_id])
    @contact = @user.send(set_type.pluralize).new
  end

  # GET /contacts/1/edit
  def edit
  end

  # POST /contacts
  def create
    @user = User.find(params[:user_id])
    @contact = @user.send(set_type.pluralize).new(contact_params)

    if @contact.save
      redirect_to @user, notice: 'Contact was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /contacts/1
  def update
    if @contact.update(contact_params)
      redirect_to @user, notice: 'Contact was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /contacts/1
  def destroy
    @contact.destroy
      redirect_to user_url(@user), notice: 'Contact was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @user = User.find(params[:user_id])
      @contact = @user.send(set_type.pluralize).find(params[:id])
    end

    def set_type
      case params[:type]
      when 'Friend'
        'friend'
      when 'Emergency'
        'emergency'
      end
    end

    # Only allow a list of trusted parameters through.
    def contact_params
      params.require(set_type.to_sym).permit(:user_id, :type, :first_name, :last_name, :phone_number, :address, :city, :state, :birthday)
    end
end
