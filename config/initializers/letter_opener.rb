LetterOpener.configure do |config|
  # Set the location for message storage
  config.location = Rails.root.join('tmp', 'letter_opener')

  # Set the message template to render only the body without metadata or extra styling
  config.message_template = :light
  config.file_uri_scheme = 'file:///mnt/c/Ubuntu-20.04.6-LTS'

end
