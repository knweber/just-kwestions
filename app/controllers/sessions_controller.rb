enable :sessions


get '/sessions/new' do
  erb :'/sessions/new', layout: false
end


post '/sessions' do
  @user = User.authenticate(params[:email], params[:password])
  if @user
    session[:user_id] = @user.id
    redirect '/'
  else
    status 422
    erb :'sessions/new', locals: { errors: ["Invalid email address or password."] }
  end
end

delete '/sessions/:id' do
  session[:user_id] = nil
  redirect '/'
end
