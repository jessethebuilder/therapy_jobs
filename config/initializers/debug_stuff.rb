def test_address
  a = Address.new
  a.street = '123 Test'
  a.city = "Port Angeles"
  a.state = "wa"
  a.zip = '98362'
  #a.save
  a
end