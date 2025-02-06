class HomeController < ApplicationController
  def index
    if user_signed_in?
      if current_user.manager?
        redirect_to manager_dashboard_path
      else
        redirect_to products_path
      end
    end
  end
end
