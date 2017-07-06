class UsersController < ApplicationController
  def index
    users = User.all

    if users
      render json: users, status: 200
    end
  end

  def create
    @user = User.new(user_params)
    unicless_email = User.find_by(email: @user.email)

    unless unicless_email
      if @user.save
        origin = request.headers['origin']
        UserMailer.registration_confirmation(@user, origin).deliver
        render :show, status: :ok
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    else
      render json: {
        message: 'Email has all ready taken'
      }, status: 207
    end
  end

  def confirm_email
    user = User.find_by_email_token(params[:id])

    if user
      user.email_activate
      render json: {
        message: 'Email address is Confirmed'
      }, status: 200
    else
      render json: {
        message: 'Email adres has all ready confirmed'
      }, status: 207
    end
  end

  def fetch_token
    user = User.find_by(token: params[:token])

    if user
      render json: user
    else
      return head(:bad_request)
    end
  end

  def create_token
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.email_confirmation
        token = SecureRandom.hex(15)
        user.attributes = {token: token}
        user.save(validate: false)
        render json: {
          token: token,
          message: 'Login successfully'
        }, status: 201
      else
        render json: {
          message: 'Email not confirmation'
        }, status: 207
      end
    else
      render json: {
        message: 'Invalid email/password combination'
      }, status: 207
    end
  end

  def destroy_token
    user = User.find_by(token: params[:token])

    if user
      user.attributes = {token: ""}
      user.save(validate: false)
      return head(:ok)
    else
      return head(:bad_request)
    end
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end