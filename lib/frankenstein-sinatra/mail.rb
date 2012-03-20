Pony.options = {
  :via => :smtp,
  :via_options => {
    :address => 'smtp.sendgrid.net',
    :port => '587',
    :domain => 'heroku.com',
    :user_name => ENV['SENDGRID_USERNAME'],
    :password => ENV['SENDGRID_PASSWORD'],
    :authentication => :plain,
      :enable_starttls_auto => true
  }
}

class Hash
  def to_mail
    mail_string = ""
    self.each {|key, val| mail_string << "<b>#{key}:</b> #{val}<br/>"}
    mail_string
  end
end
