class ApplicationRecord < ActiveRecord::Base

  self.abstract_class = true

  ALLOWED_CONTENT_TYPES = [
    'image/jpeg',
    'image/png',
    'image/gif',
    'image/bmp'
  ]

end
