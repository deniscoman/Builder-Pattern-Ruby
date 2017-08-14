class AddressBuilder
  attr_accessor :address

  def initialize
    @address = Address.new
  end

  def address
    raise "Address should have a street name" if @address.street.name.nil?
    raise "Address should have a number" if @address.street.number.nil?
    raise "Address should have a postal code" if @address.street.postal_code.nil?
    raise "Address should contain a city" if @address.city.nil?
    raise "Adress should contain a country" if @address.country.nil?
    @address
  end

  def set_country(name)
    @address.country = Country.new(name)
  end

  def set_city(name)
    @address.city = City.new(name)
  end

  def set_street(name, number, postal_code)
    @address.street = Street.new(name,number,postal_code)
  end

end

class Address
  attr_accessor :country, :city, :street
end

class Street
  attr_accessor :name, :number, :postal_code
  def initialize(name, number, postal_code)
    @name = name
    @number =number
    @postal_code = postal_code
  end
end

class City
  attr_accessor :name
  def initialize(name)
    @name = name
  end
end

class Country
  attr_accessor :name
  def initialize (name)
    @name = name
  end
end

address_builder = AddressBuilder.new
address_builder.set_country("Romania")
address_builder.set_city("Sibiu")
address_builder.set_street("Mihai Viteazu",10,550350)
address = address_builder.address

puts address.street.postal_code