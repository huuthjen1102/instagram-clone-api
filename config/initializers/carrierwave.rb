CarrierWave.configure do |config|
  if Rails.env.production?
    config.fog_credentials = {
      :provider              => 'AWS',
      :aws_access_key_id     => ENV['S3_ACCESS_KEY'],
      :aws_secret_access_key => ENV['S3_SECRET_KEY'],
      :region                => ENV['S3_REGION']
    }
    config.fog_directory = ENV['S3_BUCKET']
    config.storage = :fog
  else
    config.storage = :file
    config.asset_host = Rails.application.secrets.domain
  end
end
