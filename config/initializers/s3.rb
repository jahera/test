require 'fog'
require 'carrierwave'
CarrierWave.configure do |config|
  # if  Rails.env.production? || Rails.env.development?
  #  if Rails.env.development?
  config.storage = :fog
  config.fog_credentials = {
    :provider              => 'AWS',
    :aws_access_key_id     => 'AKIAJO3PGY7NFFZTGYDQ',
    :aws_secret_access_key => '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',
    :region => 'us-east-1'
  }
  config.fog_directory    = 'eliteguardmobile'
  # else
  #    config.storage = :file
  #    config.enable_processing = Rails.env.development?
  # end
end