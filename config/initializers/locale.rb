
# I18n environment variables

DEFAULT_LOCALE    = :sw
AVAILABLE_LOCALES = [:en, :sw]

# Where the I18n library should search for translation files

I18n.load_path += Dir[Rails.root.join('config', 'locales', '*.{rb,yml}')]

# Permitted locales available for the application

I18n.available_locales = AVAILABLE_LOCALES

# Set default locale to something other than :en

I18n.default_locale = DEFAULT_LOCALE
