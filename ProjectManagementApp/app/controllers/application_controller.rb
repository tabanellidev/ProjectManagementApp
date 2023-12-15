class ApplicationController < ActionController::Base

  before_action :authenticate_user!

  def admin?

      if current_user.role != 'admin'
       not_authorized
      end

  end

  def senior?

    if current_user.role == 'developer'
      not_authorized
    end

  end

  def not_authorized
    redirect_to :controller => "main", :action => 'notauthorized'
  end

  rescue_from 'ActionController::ParameterMissing' do |exception|
    render json: { error: 'No params provided' }, status: 401
  end

  rescue_from 'ActiveRecord::RecordNotFound' do |exception|
    render json: { error: 'Record not found' }, status: 404
  end

end
