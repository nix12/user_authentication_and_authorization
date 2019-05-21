module CustomTokenResponse
  def body
    user = User.find(@token.resource_owner_id)
    super.merge({
      user: {
        userId: user.id,
        username: user.username,
        rules: Ability.new(user).to_list
      }
    })
  end
end
