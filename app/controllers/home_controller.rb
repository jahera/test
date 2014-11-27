class HomeController < ApplicationController
  layout 'home'
  
  def index
    render :layout => false
  end
  
  def about
    
  end
  
  def blog
    
  end
  
  def contact
    
  end
  def create
    @contact = ContactUs.new(params[:contact].permit(:name,:email,:subject))
    begin
      @contact.save!
      flash[:notice] = "Thank you for giving us your time. We will contact you very soon."
      redirect_to home_contact_path
    rescue Exception => e
      flash[:error] = "#{e.message}"
      render :action => 'contact'
      # puts "===================>#{e.message}"
    end
  end
  def mobile_edition
    
  end
  
  def pc_edition
    
  end
  
  def privacy_policy
    
  end
  
  def product
    
  end
  
  def single_page
    
  end
  
  def single_page1
    
  end
  def terms_condition
    
  end
  
end
