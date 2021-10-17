class ContactController < ApplicationController
  before_action :authenticate_user!
  def index
  end
  def filter
  end
  def _filter
    limit = 10
    _filter_ = {}
    unless params[:data_file_id].blank?
      _filter_[:data_files_id] = params[:data_file_id]
    end
    
    
    if params[:offset].blank?
      _offset = 0
    else
      _offset = params[:offset].to_i
    end
    
    render json: {
      meta: {
        limit: limit,
		    offset: (_offset + limit)
      },
      status: true,
      objects: Contact
        .where(_filter_)
        .order("id desc")
        .offset(_offset).limit(limit)
    }
  end
  def check
    o = Contact._check(params)
    unless o[:error].blank?
      raise ActiveRecord::RecordInvalid.new o[:error]
      return
    end
    
    render json: {
      status: true
    }
  end
  def create
  end
end
