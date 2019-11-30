# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/json'
require './lib/url_shortener'

class URLShortener < Sinatra::Base
  @@url_list = []

  post '/shortener' do
    @new_url = Shortener.new
    @new_url = @new_url.generate_short_url
    params = JSON.parse(request.body.read)
    url = params['url']

    if !url.start_with?('http://') && !url.start_with?('https://')
      url = 'http://' + url
    end

    entry = { short_url: @new_url.to_s, url: url.to_s }

    @@url_list << entry
    json entry
  end

  get '/*' do
    requested_short_url = "/#{params['splat'].first}"
    entry = @@url_list.detect { |entry| entry[:short_url] == requested_short_url }
    redirect to(entry[:url]), 301, json(url: entry[:url])
  end
end
