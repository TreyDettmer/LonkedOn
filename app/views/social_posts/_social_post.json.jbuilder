json.extract! social_post, :id, :title, :content, :created_at, :updated_at
json.url social_post_url(social_post, format: :json)
