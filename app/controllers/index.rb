get '/' do
  erb :index
end

get '/hams' do
  1000.times { puts 'hams' }
  "HAMS"
end
