class ApplicationController < ActionController::Base

  #Per accedere a tutte le funzioni è necessaria l'autenticazione
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
    #render json: { error: 'No params provided' }, status: 401
    redirect_to :controller => "main", :action => 'errors', id: 401
  end

  rescue_from 'ActiveRecord::RecordNotFound' do |exception|
    redirect_to :controller => "main", :action => 'errors', id: 404
  end

  rescue_from 'ActiveRecord::InvalidForeignKey' do |exception|
    redirect_to :controller => "main", :action => 'errors', id: 400
  end

end
