module CustomTokenErrorResponse
  def body
    {
      status_code: 401,
      errors: I18n.t('devise.failure.invalid', authentication_keys: User.authentication_keys.join('/')),
      result: []
    }
  end
end
