class ApplicationController < ActionController::API
  def current_user
    token = request.headers['Authorization'].split(' ')[1]
    @current_user ||= User.find_by(token: token)
  end
end
