class PagesController < ApplicationController
  def home
   @leads = Lead.all
  end
end
