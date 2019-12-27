# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/json'
require './lib/url_shortener'

class URLShortener < Sinatra::Base

  set :public_folder, File.dirname(__FILE__) + '/static'

  @@url_list = []
  @@short_url_counter = Hash.new(0)
  

  get '/' do
    erb :shortener
  end

  post '/shortener' do
      shortener = Shortener.new
      short_url = shortener.generate_short_url

      params = invalid_post_request

      url = params['url']

      if url.empty?
        status 404
        return json :error => 'Invalid request'
      end

      if !url.start_with?('http://') && !url.start_with?('https://')
        url = 'http://' + url
      end

      entry = { short_url: short_url.to_s, url: url.to_s }

      @@url_list << entry
      json entry
  end

  get '/*' do
    requested_short_url = "/#{params['splat'].first}"
    entry = @@url_list.detect { |entry| entry[:short_url] == requested_short_url }

    if entry == nil
      status 404
      return json :error => 'This short URL could not be found'
    end

    @@short_url_counter[requested_short_url] += 1
    redirect to(entry[:url]), 301, json(url: entry[:url], short_url: @@short_url_counter[requested_short_url])
  end

  private 

  def invalid_post_request
      params = JSON.parse(request.body.read)
    rescue
      status 404
      return json :error => 'Invalid request'
  end 
end
