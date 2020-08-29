require 'rails_helper'

RSpec.describe Billable::DynamicFactorCalculator, type: :serice do
  let(:url) { 'https://github.com/gnomex' }
  let(:word) { 'ruby' }
  let(:instance) { described_class.new(url, word) }

  describe 'service api' do
    it { expect(instance).to respond_to(:count) }
  end

  describe '#count' do
    let(:expected_value) { 1234 }

    before do
      allow(instance).to receive(:reckoner).and_return(expected_value)
    end

    subject { instance.count }

    it 'return the word occurrences at given resource url' do
      expect(subject).to eq(expected_value)
    end
  end

  describe 'private methods' do
    describe '#reckoner' do
      let(:instance) { described_class.new(url, word) }

      subject { instance.send(:reckoner) }

      context 'XML' do
        let(:url) { 'http://www.yourlocalguardian.co.uk/sport/rugby/rss/' }
        let(:word) { 'pubDate' }

        it { expect(subject).to eq(51) }
      end

      context 'html' do
        let(:url) { 'https://developer.github.com/v3/#http-redirects' }
        let(:word) { 'status' }

        it { expect(subject).to eq(9) }
      end
    end

    describe '#resource_class_sym' do

      before do
        allow(instance).to receive(:resource).and_return(mechanized)
      end

      subject { instance.send(:resource_class_sym) }

      context 'XML' do
        let(:mechanized) { Mechanize::XmlFile.new }

        it 'returns the resource type' do
          expect(subject).to eq "XmlFile"
        end
      end

      context 'html' do
        let(:mechanized) { Mechanize::Page.new }

        it 'returns the resource type' do
          expect(subject).to eq "Page"
        end
      end
    end

    describe '#resource' do
      before do
        allow(Mechanize).to receive(:start).and_return(Mechanize.new)
      end

      subject { instance.send(:resource) }

      it 'returns a mechanize agent' do
        expect(subject).to be_an_instance_of Mechanize
      end
    end
  end

end
