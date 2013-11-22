class AddressesController < ApplicationController
  before_action :set_address, only: [:show, :edit, :update, :destroy, :map_to]

  # GET /addresses
  def index
    @addresses = Address.all
  end

  # GET /addresses/1
  def show
  end

  # GET /addresses/new
  def new
    @address = Address.new
  end

  # GET /addresses/1/edit
  def edit
  end

  # POST /addresses
  def create
    @address = Address.new(address_params)

    if @address.save
      redirect_to @address, notice: 'Address was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /addresses/1
  def update
    if @address.update(address_params)
      redirect_to @address, notice: 'Address was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /addresses/1
  def destroy
    @address.destroy
    redirect_to addresses_url, notice: 'Address was successfully destroyed.'
  end

  def map_to
    @map_to_address = Address.new
    @map_to_address.send(:address_string=, params[:address_string])
    @map_to_address.geocode
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_address
    @address = Address.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def address_params
    #params[:address]
    params.require(:address).permit(:street, :street2, :street3, :city, :state, :zip, :latitude, :longitude,
                                    :spammable, :address_string)
  end
end