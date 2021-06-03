require 'carrierwave/storage/fog'

if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     Rails.application.credentials.aws[:S3_ACCESS_KEY],
      aws_secret_access_key: Rails.application.credentials.aws[:S3_SECRET_KEY]
    }

    config.fog_directory  = Rails.application.credentials.aws[:S3_BUCKET_NAME]
  end
end
