enable :sessions


get '/login' do
  erb :'/sessions/login', layout: false
end


post '/login' do
  @user = User.authenticate(params[:email], params[:password])
  if @user
    session[:user_id] = @user.id
    redirect '/'
  else
    status 422
    erb :'sessions/login', locals: { errors: ["Invalid email address or password."] }
  end
end

post '/logout' do
  session[:user_id] = nil
  redirect '/'
end
