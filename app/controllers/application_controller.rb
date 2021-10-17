class ApplicationController < ActionController::Base
  include ApplicationHelper
  
  rescue_from ActiveRecord::RecordNotFound, with: :render_error
  rescue_from ActionController::ParameterMissing, with: :render_error
  rescue_from ActiveRecord::RecordInvalid, with: :render_error
  def render_error(exception = nil)
    if not exception.nil?
      @message = exception.message
    else
      @message = "Ups, Something has gone bad."
    end

    respond_to do |format|
      format.html { render template: 'errors/401', layout: 'layouts/error', status: 401 }
      format.json { render json: {status: false, meta: {msg: @message}}, status: 401 }
      format.all { render nothing: true, status: 401 }
    end
  end    
end
