
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    callback_for(:facebook)
  end

  def twitter
    callback_for(:twitter)
  end

  def google_oauth2
    callback_for(:google)
  end

# 提供元のアカウント情報を活用してログイン処理を実行
  def callback_for(provider)
    data = request.env["omniauth.auth"].except("extra")
    @user = User.from_omniauth(data)
    if @user
      sign_in @user
      flash[:success] = "#{provider}アカウントを利用してログインしました"
      redirect_to index_path
    else
      user = data[:info]
      @user = User.new(
        name: user.name,
        email: user.email,
        image: user.image,
        provider: provider,
        uid: data.uid    
      )

      flash.now[:info] = "必要事項を入力し、アカウントを作成してください"
      render template: "users/registrations/new"
    end
  end

  def failure
    redirect_to root_path
  end
end
