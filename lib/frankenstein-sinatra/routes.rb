get '/stylesheets/:name.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass(:"stylesheets/#{params[:name]}", Compass.sass_engine_options)
end

get '/js/:name.js' do
  content_type 'text/javascript', :charset => 'utf-8'
  coffee :"javascripts/#{params[:name]}"
end
