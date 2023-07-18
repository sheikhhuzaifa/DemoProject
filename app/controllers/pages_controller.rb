class PagesController < ApplicationController
  def assigned_lead
  @leads = Lead.all
  end
end
