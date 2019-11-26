class ApplicationController < ActionController::API

  around_action :switch_locale

  # Extract locale from data :-
  # params, user preferences, request header env and then domain name.

  def switch_locale(&action)
    locale = Configuration::I18n.new(params).call
    I18n.with_locale(locale, &action)
  end

  # Enables us to set default locale for `url_for`
  # and any helper methods dependent on it.

  def default_url_options
    { locale: I18n.locale }
  end

end
