class IssueFileController < ApplicationController
  before_action :authenticate_user!
  def _filter
  	limit = 10
  	
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
      objects: IssueFile
          .where(data_files_id: params[:data_file_id])
          .order(:line)
          .offset(_offset).limit(limit)
    }
  end
end