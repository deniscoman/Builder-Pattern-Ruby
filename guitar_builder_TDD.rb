class GuitarBuilder
  attr_reader :guitar
  def initialize()
    @guitar = Guitar.new
  end

  def build
    raise "Too few strings" if @guitar.number_of_strings < 10
    raise "Too many strings" if @guitar.number_of_strings > 20
    raise "No material specified" if @guitar.body.material.empty?
    raise "Negative width" if @guitar.body.width <= 0
    raise "Negative depth" if @guitar.body.depth <= 0

    raise "Sound hole diameter is too small" if @guitar.sound_hole_diameter < 10
    raise "Sound hole diameter is too big" if @guitar.sound_hole_diameter > 20
    @guitar
  end

  def select_number_of_strings(number)
    @guitar.build_strings(number)
  end

  def craft_body(material,width,depth)
    @guitar.body = GuitarBody.new(material,width,depth)
  end

  def configure_strings(string_length,string_tension,string_linear_density)
    @guitar.strings.each do |string|
      string.length = string_length
      string.tension = string_tension
      string.linear_density = string_linear_density
    end
  end

  def body_color(color)
    @guitar.body.color = color
  end

  def set_sound_hole_diameter(diameter)
    @guitar.sound_hole = SoundHole.new(diameter)
  end

  def add_fretboard(length,width)
    @guitar.fretboard = FretBoard.new(length,width)
  end
end

class Guitar
  attr_accessor :strings, :body, :sound_hole, :fretboard
  def initialize
    @strings = []
  end

  def build_strings(number)
    number.times do
      @strings.push GuitarString.new
    end
  end

  def number_of_strings
    @strings.length
  end

  def sound_hole_diameter
    @sound_hole.diameter
  end
end

class GuitarString
  attr_accessor :length, :tension, :linear_density
end

class GuitarBody
  attr_reader :material, :depth, :width
  attr_accessor :color
  def initialize(material,width,depth)
    @material = material
    @width = width
    @depth = depth
  end
end

class SoundHole
  attr_reader :diameter
  def initialize(diameter)
    @diameter = diameter
  end
end

class FretBoard
  attr_reader :length, :width
  def initialize(length,width)
    @length = length
    @width = width
  end
end