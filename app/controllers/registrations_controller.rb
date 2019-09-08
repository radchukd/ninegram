class RegistrationsController < Devise::RegistrationsController
  def new
    user = super
    user.avatar = './app/assets/images/user.jpg'
  end

private

  def sign_up_params
    params.require(:user).permit(:name,
                                 :email,
                                 :password,
                                 :password_confirmations,
                                 :avatar,
                                 :nickname,
                                 :bio)
  end

  def account_update_params
    params.require(:user).permit(:name, 
                                 :email,
                                :password,
                                :password_confirmations,
                                :current_password,
                                :avatar,
                                :nickname,
                                :bio)
  end
end