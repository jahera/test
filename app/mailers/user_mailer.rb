class UserMailer < ActionMailer::Base
  default :from => "Elite Team <do-not-reply@eliteteam.co>"
  
  def welcome_email(user)
    @user = user
    @url = "http://192.168.0.20:3000/download"
    @recipients   = user.email.strip
    #    @bcc          = "contact@ezwebguru.com"
    @from         = "Elite Team <do-not-reply@ourprojectteam.com>"
    @content_type = "text/html"
    @sent_on      = Time.now.utc    
    to = user.email.strip
    #@subject      = "New account has been created at ourprojectteam.com"
    #    @body         = {:user => user, :url => url}    
    mail(:to => to, :subject => "New account has been created at MobileSnoop.com") do |format|
      format.html { render "user_mailer/welcome_email" }
    end
  end
  
  def notification_for_term_condition(user)
    @user = user
    #    @url = "http://192.168.0.20:3000/terms-conditions"
    @url = "http://www.eliteguard.in/users/sign_in"
    @recipients   = user.email.strip
    #    @bcc          = "contact@ezwebguru.com"
    @from         = "Elite Guard <do-not-reply@mobilesnoop.com>"
    @content_type = "text/html"
    @sent_on      = Time.now.utc    
    to = user.email.strip
    #@subject      = "New account has been created at ourprojectteam.com"
    #    @body         = {:user => user, :url => url}    
    mail(:to => to, :subject => "New account has been created at eliteguard.in") do |format|
      format.html { render "user_mailer/notification_for_term_condition" }
    end
  end
  
end
