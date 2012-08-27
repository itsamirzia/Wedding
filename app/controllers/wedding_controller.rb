class WeddingController < ApplicationController
   include ApplicationHelper
  before_filter :protect

  def index
    @title = "Welcome to AnSWedding.com"
  end

  def card
    @title = "Your Wedding Card :)"
  end

  def photos
    @title = "AnSWedding Photo"
  end

  def quotation
    @title = "Marriage Quotations"
  end

  def contact
    @title = "Contact Us"
  end

  def detail
    @title = "Marriage And Program Details"
  end
  def venue
    @title="Venue for AnSWedding"
  end

  private
  def protect
  unless session[:user_id]
flash[:notice] = "Please log in first"
redirect_to :action => "login", :controller=>"user"
return false
end
end
end
