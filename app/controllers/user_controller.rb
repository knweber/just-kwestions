get '/users/new' do
  erb :'/users/new'
end


post '/users' do

  user = User.new(params[:user])

  if params[:user][:password].empty? ||   params[:user][:password].length < 8
    user.valid?
    return erb :'/users/new', locals: { errors: user.errors.full_messages << "Must provide password of at least 8 characters." }
  end


  if user.valid?
    user.save!
    session[:user_id] = user.id
    redirect "/"
  else
    erb :'/users/new', locals: { errors: user.errors.full_messages }
  end

end
