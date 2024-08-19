class Shortcut < ApplicationRecord
  validates :full_url, presence: true
  validates :full_url, url: true

  before_create :generate_shortcut_url

  def accessed
    self.update(click_count: (self.click_count||0) + 1)
  end

  private
  def generate_shortcut_url
    self.short_url = UUID.new.generate.split("-")[0]
  end
end
