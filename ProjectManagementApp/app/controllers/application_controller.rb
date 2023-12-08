class ApplicationController < ActionController::Base

  before_action :authenticate_user!

  def admin?

      if current_user.role != 'admin'
        redirect_to :controller => "main", :action => 'notauthorized'
      end

  end

  def senior?

    if current_user.role == 'developer'
      redirect_to :controller => "main", :action => 'notauthorized'
    end

  end


end
