class CustomDeviseApi::UsersController < DeviseTokenAuth::RegistrationsController
  include DeviseTokenAuth::Concerns::SetUserByToken
    before_action :set_user_by_token, only: [:destroy, :update]
    before_action :validate_sign_up_params, only: :create
    before_action :validate_account_update_params, only: :update
    skip_after_action :update_auth_header, only: [:create, :destroy]

    #signup user with email if not already registered
    def signup_email
      user = User.find_by(email: email_signup_params[:email])
      if user.nil?
        user= User.new(email: email_signup_params[:email], password: email_signup_params[:password])
        if user.save
          render json: user.to_json, only: [:email, :password], status: :created
        else
          render json: user.errors.full_message, status: :unprocessable_entity
        end
      else
        render json: user.to_json, only: [:email, :password], status: :found
      end
    end

    #signin user with email if user is registered
    def signin_email
      user = User.where(email: email_signin_params[:email], password:email_signin_params[:password])
      if !user.nil?
        render json: user, status: :found
      else
        render json: user.errors.full_message, status: :unprocessable_entity
      end
    end

    #user try to signup with phone number, api generates OTP for that number here
    def signin
      user = User.where(mobile_number: sigin_params[:mobile_number])
      if !user.empty?
        user.update(otp: loop do
          generated_otp =rand(1e5...1e6).to_i
          break generated_otp unless User.where(otp:generated_otp).exists?
        end)
        render json: user.to_json, only: [:otp], status: :ok
      else
        render json: user.errors.full_message, status: :not_found
      end
    end

    #user signin by entering the OTP being generated against it's number in the last step
    def verify_mobile_signin
      check = User.where(mobile_number: verify_mobile_signin_params[:mobile_number], otp: verify_mobile_signin_params[:otp])
      if !check.empty?
        render json: check, status: :ok
      else
        render json: check, status: :not_found
      end
    end

    # add sports_complex check to "true" in User model
    def register_sports_complex
      check = User.where(email: sports_complex_register_params[:email])
      if !check.empty?
        check.update(sports_complex_check:true)
        render json: check, status: :ok
      else
        render json: check, status: :not_found
      end
    end

    def add_sports_complex_data
      
    end



    private
    def sigin_params
      params.permit(:mobile_number)
    end
    def verify_mobile_signin_params
      params.permit(:otp, :mobile_number)
    end

    def sports_complex_register_params
      params.permit(:email)
    end

    def email_signup_params
      params.permit(:email, :password)
    end

    def email_signin_params
      params.require(:user).permit(:email, :password, :password_confirmation, :role, :otp, :name, :city, :address, :mobile_number, :active_status)
    end
end
