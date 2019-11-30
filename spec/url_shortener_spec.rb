# frozen_string_literal: true

require 'url_shortener'

describe Shortener do
  describe '#generate_short_url' do
    it 'will generate a string' do
      expect(subject.generate_short_url).to be_an_instance_of(String)
    end

    it 'will generate a short url with a length of 7' do
      expect(subject.generate_short_url.length).to eq(7)
    end
  end
end
