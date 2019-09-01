class RegistrationsController < Devise::RegistrationsController

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