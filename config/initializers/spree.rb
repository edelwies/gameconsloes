# Configure Spree Preferences
#
# Note: Initializing preferences available within the Admin will overwrite any changes that were made through the user interface when you restart.
#       If you would like users to be able to update a setting with the Admin it should NOT be set here.
#
# Note: If a preference is set here it will be stored within the cache & database upon initialization.
#       Just removing an entry from this initializer will not make the preference value go away.
#       Instead you must either set a new value or remove entry, clear cache, and remove database entry.
#
# In order to initialize a setting do:
# config.setting_name = 'new value'
Spree.config do |config|
  # Example:
  # Uncomment to stop tracking inventory levels in the application
  # config.track_inventory_levels = false
  config.currency = 'IRR'

end

SpreeI18n::Config.available_locales = [:en, :fa]
SpreeI18n::Config.supported_locales = [:en, :fa]
Spree.user_class = 'Spree::User'
Devise.secret_key = "b4d2542590f5dbda70061871468fe2a1264159a171a0838b76bbadd35936df68e8d54079af3a018c01c05dac8f6056522bcf"
