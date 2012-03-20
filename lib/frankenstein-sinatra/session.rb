enable :sessions
set :session_secret, (ENV['SESSION_KEY'] || 'NOSECRET')
