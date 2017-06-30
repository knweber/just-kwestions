get '/users/new' do
  erb :'/users/new', layout: false
end


post '/users' do

  @user = User.new(params[:user])
    if !params[:user][:password].valid?
      return erb :'/users/new', locals: { errors: ["Must provide password of at least 8 characters."] }
    end

  @user.password = params[:user][:password]
  if @user.valid?
    @user.save!
    redirect "/"
  else
    erb :'/users/new', locals: { errors: @user.errors.full_messages }
  end

end
