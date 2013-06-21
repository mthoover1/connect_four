helpers do

  def current_user
    @user ||= User.find_by_id(session[:id])
  end
  
end
