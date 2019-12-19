# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/json'
require './lib/url_shortener'

class URLShortener < Sinatra::Base

  set :public_folder, File.dirname(__FILE__) + '/static'

  @@url_list = []

  get '/' do
    erb :shortener
  end

  post '/shortener' do
      shortener = Shortener.new
      short_url = shortener.generate_short_url

      begin
        params = JSON.parse(request.body.read)
      rescue
        status 404
        return json :error => 'Invalid request'
      end

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

    redirect to(entry[:url]), 301, json(url: entry[:url])
  end
end
