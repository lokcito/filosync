class DataFileController < ApplicationController
  before_action :authenticate_user!
  def index
  end
  def show
		begin
			@dataFile = DataFile.find(params[:id])
		rescue
			raise ActiveRecord::RecordNotFound.new("Data file not found.")
			return
		end
		  	
  end
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
  		objects: DataFile.all
  			.order("id desc")
  			.offset(_offset).limit(limit)
  	}
  end
  def sync
		begin
			dataFile = DataFile.find(params[:id])
		rescue
			raise ActiveRecord::RecordNotFound.new("Data file not found.")
			return
		end
		
		dataFile.sync
		
  	render json: {
  		status: true,
  	}
  end  
  def create
  	if params[:format_content] == "plain/text"
  			request_file = {
  				content: params[:content]
  			}
  	else
			request_file = get_request_file(params[:csv_file])
		end
		

    unless params[:columns].present?
			raise ActionController::ParameterMissing
			  .new('Does not exist columns to match.')
			return
    end
    

		columns = params[:columns].split("|")

		if columns.count != 7
			raise ActionController::ParameterMissing
			  .new('Does not exist columns to match.')
			return
		end

		if (columns - DataFile.static_columns).count > 0
			raise ActionController::ParameterMissing
			  .new('Columns are malformed.')
			return
		end
		
		filename = DataFile.get_namefile_to_store()
		store_path = DataFile.get_path_to_store(filename)
    
		if File.exists?(store_path)
			raise ActionController::ParameterMissing.
			  new('Document already exists.')
			return
		end

		File.open(store_path, 'wb') do |f|
			f.write request_file[:content]
		end

    unless File.exists?(store_path)
			raise ActionController::ParameterMissing.
			  new('Something has gone bad.')
			return
		end		

    result = DataFile._create({
      columns: params[:columns],
      filename: filename,
      user_id: current_user.id
    })
    unless result[:error].blank?
      raise ActiveRecord::RecordInvalid.new result[:error]
      return
    end
		
    render json: {
      status: true,
      object: result[:object]
    }
  end
end
