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

  rescue_from 'ActionController::ParameterMissing' do |exception|
    render json: { error: 'No params provided' }, status: 401
  end

end
