## Manage the locale for each request

# Docs: https://guides.rubyonrails.org/i18n.html#managing-the-locale-across-requests


# Things to consider
#   1.
module Configuration
  class I18n

    def initialize(params)
      @params = params
    end

    def call()
      [
        :extract_locale_from_uri_params
        :extract_locale_from_query_params,
        :extract_locale_from_current_user,
        :extract_locale_from_accept_language,
        :extract_locale_from_domain_name,
      ].each do |command|
        result = send(command)
        next if result[:success] == false
        return result[:locale]
      end
    end

    private

    # Set locale from query params
    # e.g `http://example.com/books?locale=pt`

    def extract_locale_from_query_params
      return failed_to_load_locale unless @params[:locale].present?
      { success: true, locale: @params[:locale] }
    end


    # Set locale from domain name. (ONLY at end of the domain)
    # e.g `http://www.example.es`

    def extract_locale_from_domain_name
      parsed_locale = request.host.split('.').last
      unless I18n.available_locales.map(&:to_s).include?(parsed_locale)
        return failed_to_load_locale
      end
      { success: true, locale: parsed_locale }
    end

    # Set locale from URI params
    # e.g `http://www.example.com/ds/...`

    alias_method
      :extract_locale_from_uri_params
      :extract_locale_from_query_params

    # Set locale from User preference

    def extract_locale_from_current_user
      return failed_to_load_locale unless current_user&.locale.present?
      { success: true, locale: current_user.locale }
    end

    # Set locale from request header variables

    def extract_locale_from_accept_language
      locale = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
      { success: true, locale: locale }
    rescue
      failed_to_load_locale
    end

    def failed_to_load_locale
      { success: false, locale: I18n.default_locale }
    end

  end
end