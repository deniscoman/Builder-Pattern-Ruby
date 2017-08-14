class GuitarBuilder
  attr_reader :guitar

  def initialize()
    @guitar = Guitar.new
  end

  def guitar
    raise "too few strings" if @guitar.number_of_strings < 4
    raise "too many strings" if @guitar.number_of_strings > 12
    raise "improper body" if @guitar.body.width > 32 || @guitar.body.depth < 12
    raise "sound hole too small" if @guitar.sound_hole_diameter < 6
    raise "sound hole too large" if @guitar.sound_hole_diameter > 36
    @guitar
  end

  def select_number_of_strings(number)
    @guitar.build_strings(number)
  end

  def configure_strings(string_length, string_tension, string_linear_density)
    @guitar.strings.each do |string|
      string.length = string_length
      string.tension = string_tension
      string.linear_density = string_linear_density
    end
  end

  def craft_body(material, width, depth)
    @guitar.body = GuitarBody.new(material, width, depth)
  end

  def paint_body(color)
    @guitar.body.color = color
  end

  def set_sound_hole_diameter(diameter)
    @guitar.sound_hole = SoundHole.new(diameter)
  end

  def add_fretboard(length, width)
    @guitar.fretboard = FretBoard.new(length, width)
  end
end

class Guitar
  attr_accessor :body, :sound_hole, :fretboard, :strings

  def initialize
    @strings = []
  end

  def sound_hole_diameter
    @sound_hole.diameter
  end

  def number_of_strings
    @strings.length
  end

  def build_strings(number)
    number.times do
      @strings.push GuitarString.new
    end
  end
end

class GuitarString
  attr_accessor :length, :tension, :linear_density
end

class GuitarBody
  attr_reader :material, :width, :depth
  attr_accessor :color
  def initialize(material, width, depth)
    @material = material
    @width = width
    @depth = depth
  end
end

class SoundHole
  attr_reader :diameter
  def initialize (diameter)
    @diameter = diameter
  end
end

class FretBoard
  attr_reader :length, :width
  def initialize(length, width)
    @length = length
    @width = width
  end
end

 # guitar_builder = GuitarBuilder.new
 # guitar_builder.select_number_of_strings(3)
 # guitar_builder.configure_strings(27, 4, 0.7)
 # guitar_builder.craft_body("cedar", 24, 12)
 # guitar_builder.paint_body("cherry red")
 # guitar_builder.set_sound_hole_diameter(6)
 # guitar_builder.add_fretboard(27, 3)
 #
 # guitar = guitar_builder.guitar
 #
 # puts guitar.inspect

