module LoginHelper
  def login_as(user)
    OmniAuth.config.add_mock(
      user.provider,
      uid: user.uid
    )
    visit root_path
    click_on 'GitHubアカウントでログイン'
    @current_user = user
  end

  def current_user
    @current_user
  end
end
