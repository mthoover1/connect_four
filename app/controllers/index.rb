get '/' do
  erb :index
end

get '/logout' do
  session.clear
  redirect '/'
end

get '/signup' do
  erb :signup
end

get '/login' do
  erb :login
end

post '/login' do
  if User.authenticated?(params[:user][:username], params[:user][:password])
    session[:id] = User.find_by_username(params[:user][:username]).id
    redirect '/'
  else
    redirect '/login'
  end
end

post '/createuser' do 
  user = User.create_user(params[:user])
  session[:id] = user.id
  redirect '/'
end

get '/board' do
  erb :board
end

post '/game/checkvictory' do
  content_type :json
  { winner: Game.new.winner?(params[:board]), board: params[:board] }.to_json
end
