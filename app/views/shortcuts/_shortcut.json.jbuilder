json.extract! shortcut, :id, :short_url, :full_url, :title, :click_count, :created_at, :updated_at
json.url shortcut_url(shortcut, format: :json)
