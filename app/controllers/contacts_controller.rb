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
  # POST /contacts.json
  def create
    @user = User.find(params[:user_id])
    @contact = @user.send(set_type.pluralize).new(contact_params)

    respond_to do |format|
      if @contact.save
        format.html { redirect_to @contact, notice: 'Contact was successfully created.' }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contacts/1
  # PATCH/PUT /contacts/1.json
  def update
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to @contact, notice: 'Contact was successfully updated.' }
        format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url, notice: 'Contact was successfully destroyed.' }
      format.json { head :no_content }
    end
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
