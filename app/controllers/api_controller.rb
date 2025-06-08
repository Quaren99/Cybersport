class ApiController < ActionController::API
  around_action :switch_locale

  @@limit = 15

  def default_url_options
    { locale: I18n.locale }
  end

  def switch_locale(&)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &)
  end
end
