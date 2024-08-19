require 'net/http'

class UpdateShortcutTitlesJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Shortcut.find_each(batch_size: 100)  do |shortcut|
      shortcut.update(title: Nokogiri::HTML::Document.parse(Net::HTTP.get(URI(shortcut.full_url))).title)
    end
  end
end
