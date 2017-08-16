require_relative './guitar_builder_TDD'
require 'rspec'

require "yaml"

describe GuitarBuilder do
  let(:guitar_builder){GuitarBuilder.new}
  let(:guitar) { Guitar.new }
  before(:each) do
    allow(Guitar).to receive(:new).and_return(guitar)
  end

  describe '#select_number_of_strings' do
    let(:number) {10}
    subject {guitar_builder.select_number_of_strings(number) }
    it 'should select number of the strings from the guitar' do
      subject
      expect(guitar.strings.length).to eq number
    end
  end

  describe '#craft_body' do
    let(:material) {"cedar"}
    let(:width) {10}
    let(:depth) {10}
    subject {guitar_builder.craft_body(material,width,depth)}
    it 'should add material' do
      subject
      expect(guitar.body.material).to eq material
    end
    it 'should add width' do
      subject
      expect(guitar.body.width).to eq width
    end
    it 'should add depth' do
      subject
      expect(guitar.body.depth).to eq depth
    end
  end

  describe '#configure_strings' do
    let(:number){10}
    let(:string_length){10}
    let(:string_tension){10}
    let(:string_linear_density) {10}
    subject{guitar_builder.configure_strings(string_length,string_tension,string_linear_density)}
    before do
      guitar_builder.select_number_of_strings(number)
    end
    it 'should add string length' do
      subject
      guitar.strings.each do |strings|
        expect(strings.length).to eq string_length
      end
    end

    it 'should add string tension' do
      subject
      guitar.strings.each do |strings|
        expect(strings.tension).to eq string_tension
      end
    end

    it 'should add string linear_density' do
      subject
      guitar.strings.each do |strings|
        expect(strings.linear_density).to eq string_linear_density
      end
    end
  end

  describe '#body_color' do
    let(:color){'blue'}
    let(:material) {"cedar"}
    let(:width) {10}
    let(:depth) {10}
    subject {guitar_builder.body_color(color)}
    before do
      guitar_builder.craft_body(material,width,depth)
    end
    it 'should add color' do
      subject
      expect(guitar.body.color).to eq color
    end
  end

  describe '#set_sound_hole_diameter' do
    let(:diameter){10}
    subject{guitar_builder.set_sound_hole_diameter(diameter)}
    it 'should set sound hole diameter' do
      subject
      expect(guitar.sound_hole.diameter).to eq diameter
    end
  end

  describe '#add_fretboard' do
    let(:length){10}
    let(:width){10}
    subject{guitar_builder.add_fretboard(length,width)}
    it 'should add fretboard length' do
      subject
      expect(guitar.fretboard.length).to eq length
    end

    it 'shold add frteboard width' do
      subject
      expect(guitar.fretboard.width).to eq width
    end
  end
  subject {guitar_builder.build}
  describe '#guitar' do
    context 'with too few strings' do
      before do
        guitar_builder.select_number_of_strings(3)
      end
      it 'should raise too few strings' do
        expect{subject }.to raise_error('Too few strings')
      end
    end

    context 'with too few strings' do
      before do
        guitar_builder.select_number_of_strings(23)
      end
      it 'should raise too many strings' do
       expect{ subject }.to raise_error('Too many strings')
      end
    end

    context 'with correct number of strings but no material specified' do
      before do
        guitar_builder.select_number_of_strings(15)
        guitar_builder.craft_body('',10, 10)
      end
      it 'should raise no material specified' do
        expect {subject}.to raise_error('No material specified')
      end
    end

    context 'with correct number of strings but negative width' do
      before do
        guitar_builder.select_number_of_strings(15)
        guitar_builder.craft_body('cedar',-2, 10)
      end
      it 'should raise negative width' do
        expect {subject}.to raise_error('Negative width')
      end
    end

    context 'with correct number of strings but negative depth' do
      before do
        guitar_builder.select_number_of_strings(15)
        guitar_builder.craft_body('cedar',10, -2)
      end
      it 'should raise negative depth' do
        expect {subject}.to raise_error('Negative depth')
      end
    end

    context 'with correct number of strings, good craft, strings with all atributes but sound hole diameter is too small' do
      before do
        guitar_builder.select_number_of_strings(15)
        guitar_builder.craft_body('cedar',10, 10)
        guitar_builder.configure_strings(nil,nil,nil)
        guitar_builder.set_sound_hole_diameter 5
      end
      it 'should raise sound hole diameter is too small' do
        expect {subject}.to raise_error('Sound hole diameter is too small')
      end
    end

    context 'with correct number of strings, good craft, strings with all atributes but sound hole diameter is too large' do
      before do
        guitar_builder.select_number_of_strings(15)
        guitar_builder.craft_body('cedar',10, 10)
        guitar_builder.configure_strings(nil,nil,nil)
        guitar_builder.set_sound_hole_diameter 25
      end
      it 'should raise sound hole diameter is too big' do
        expect {subject}.to raise_error('Sound hole diameter is too big')
      end
    end
  end
end