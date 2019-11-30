# frozen_string_literal: true

class Shortener
  LETTERS = Array('a'..'z')

  def generate_short_url
    short_url = Array.new(6) { LETTERS.sample }.join
    "/#{short_url}"
  end
end
