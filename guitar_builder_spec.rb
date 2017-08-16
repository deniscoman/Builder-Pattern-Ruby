require './spec_helper'

describe GuitarBuilder do
  let(:guitar_builder) { GuitarBuilder.new }
  describe '#guitar' do
    subject { guitar_builder.guitar }
    context 'with few strings' do
      before do
        guitar_builder.select_number_of_strings(3)
      end
      it 'should raise too few strings' do
        expect{ subject }.to raise_error("too few strings")
      end
    end

    context 'with many strings' do
      before do
        guitar_builder.select_number_of_strings(20)
      end
      it 'should raise too many strings' do
        expect{ subject }.to raise_error("too many strings")
      end
    end

    context 'with corect number of strings but body width is too big' do
      before do
        guitar_builder.select_number_of_strings(7)
        guitar_builder.craft_body("cedar",36, 12)
      end
      it 'should raise improper body' do
        expect { subject }.to raise_error("improper body")
      end
    end

    context 'with correct number of strings but body depth is to small' do
      before do
        guitar_builder.select_number_of_strings(6)
        guitar_builder.craft_body("cedar",30, 10)
      end
      it 'should raise improper body' do
        expect { subject }.to raise_error("improper body")
      end
    end

    context 'with correct number of strings, correct width and depth but sound hole diameter is too small' do
      before do
        guitar_builder.select_number_of_strings(6)
        guitar_builder.craft_body("cedar",30, 14)
        guitar_builder.set_sound_hole_diameter(4)
      end
      it "should raise sound hole too small" do
        expect { subject }.to raise_error("sound hole too small")
      end
    end

    context 'with correct number of strings, correct width and depth but sound hole diameter is too big' do
      before do
        guitar_builder.select_number_of_strings(6)
        guitar_builder.craft_body("cedar",30, 14)
        guitar_builder.set_sound_hole_diameter(40)
      end
      it "should raise sound hole too large" do
        expect { subject }.to raise_error("sound hole too large")
      end
    end
  end

  let(:guitar) { Guitar.new }
  before(:each) do
    allow(Guitar).to receive(:new).and_return(guitar)
  end

  describe '#set_sound_hole_diameter' do
    let(:diameter) { 10 }
    subject { guitar_builder.set_sound_hole_diameter(diameter) }
    it 'should sets correct diameter on the guitar' do
      subject
      expect(guitar.sound_hole_diameter).to eq diameter
    end
  end

  describe '#craft_body' do
    let(:material){ "cedar" }
    let(:width) { 10 }
    let(:depth) { 10 }
    subject {guitar_builder.craft_body(material, width, depth)}
    it ' should sets correct material for the guitar' do
      expect(subject.material).to eq material
    end
    it ' should sets correct width for the guitar' do
      expect(subject.width).to eq width
    end
    it ' should sets correct depth for the guitar' do
      expect(subject.depth).to eq depth
    end
  end

  describe '#paint_body' do
    let(:color) { "blue" }
    let(:material){ "cedar" }
    let(:width) { 10 }
    let(:depth) { 10 }
    subject {guitar_builder.paint_body(color)}
    before do
      guitar_builder.craft_body(material, width, depth)
    end
    it 'should sets correct color to the guitar' do
      subject
      expect(guitar.body.color).to eq color
    end
  end

  describe '#add_fretboard' do
    let(:length) { 10 }
    let(:width) { 10 }
    subject {guitar_builder.add_fretboard(length, width) }
    it 'should add length to the guitar' do
      expect(subject.length).to eq length
    end
    it 'should add width to the guitar' do
      expect(subject.length).to eq width
    end
  end

  describe '#select_number_of_strings' do
    let(:number) {10}
    subject {guitar_builder.select_number_of_strings(number) }
    it 'should select number of the strings from the guitar' do
      subject
      expect(guitar.strings.length).to eq number
    end
  end

  describe '#configure_strings' do
    let(:number) {10}
    let(:string_length) {10}
    let(:string_tension) {10}
    let(:string_linear_density) {10}
    subject { guitar_builder.configure_strings(string_length, string_tension, string_linear_density) }
    before do
      guitar_builder.select_number_of_strings(number)
    end
    it 'should configure strings length' do
      subject
      guitar.strings.each do |strings|
        expect(strings.length).to eq string_length
      end
    end

    it 'should configure strings tension' do
      subject
      guitar.strings.each do |strings|
        expect(strings.tension).to eq string_tension
      end
    end

    it 'should configure strings linear density' do
      subject
      guitar.strings.each do |strings|
        expect(strings.linear_density).to eq string_linear_density
      end
    end
  end
end