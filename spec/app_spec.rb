# frozen_string_literal: true

require File.expand_path 'spec_helper.rb', __dir__
require './app'

ENV['APP_ENV'] = 'test'

describe URLShortener do
  before :each do
    data = '{"url": "https://www.farmdrop.com/london/recipes/555/chickpea-squash-and-coconut-curry"}'
    post('/shortener', data, 'CONTENT_TYPE' => 'application/json')
    @last_post_response = last_response
    @post_response_hash = JSON.parse(@last_post_response.body)
  end

  describe 'POST /shortener' do
    it 'returns a 200 status' do
      expect(@last_post_response.status).to eq 200
    end

    it 'returns a short url with a length of 7 characters' do
      expect(@post_response_hash['short_url'].length).to eq(7)
    end

    it "adds 'http://' to the beginning of a URL that is missing it" do
      data = '{"url": "www.farmdrop.com/london/recipes/555/chickpea-squash-and-coconut-curry"}'
      post('/shortener', data, { 'CONTENT_TYPE' => 'application/json' })
      response_hash = JSON.parse(last_response.body)
      expect(response_hash['url']).to eq('http://www.farmdrop.com/london/recipes/555/chickpea-squash-and-coconut-curry')
    end
  end

  describe 'GET /{SHORT_URL}' do
    it 'returns a 301 status' do
      get @post_response_hash['short_url']
      expect(last_response.status).to eq 301
    end

    it 'returns a Location header containing the long URL' do
      get @post_response_hash['short_url']
      expect(last_response.header['Location']).to eq('https://www.farmdrop.com/london/recipes/555/chickpea-squash-and-coconut-curry')
    end

    it 'returns a JSON response containg the long URL' do
      get @post_response_hash['short_url']
      response_hash = JSON.parse(last_response.body)
      expect(response_hash['url']).to eq('https://www.farmdrop.com/london/recipes/555/chickpea-squash-and-coconut-curry')
    end

    it 'stores the number of times someone uses the shortened url' do 
      get @post_response_hash['short_url']
      response_hash = JSON.parse(last_response.body)
      expect(response_hash).to include({'short_url' => 1})
    end 

    it 'stores the number of times someone uses the shortened url' do 
      get @post_response_hash['short_url']
      get @post_response_hash['short_url']
      response_hash = JSON.parse(last_response.body)
      expect(response_hash).to include({'short_url' => 2})
    end 
  end

  describe 'GET /' do
    it 'returns a 200 status' do
      expect(last_response.status).to eq 200
    end
  end
end