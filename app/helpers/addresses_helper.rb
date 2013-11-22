module AddressesHelper
  def geocode_address
    address.geocode
  end

  def states_for_select(selected_states = nil)
    #if selected_states
      options_for_select(Address::STATES.invert, selected_states)
    #else
    #  options_for_select(Address::STATES.invert)
    #end
  end
end
