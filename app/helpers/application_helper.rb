module ApplicationHelper
    def get_request_file(file_data)
    	if not file_data.nil? and file_data.respond_to?(:read)
    		filename = file_data.original_filename
    		xml_contents = file_data.read
    	elsif not file_data.nil? and file_data.respond_to?(:path)
    		filename = file_data.original_filename
    		xml_contents = File.read(file_data.path)
    	else
    		return {
    			:filename => nil,
    			:content => nil
    		}
    	end		
    	return {
    		:filename => filename,
    		:content => xml_contents
    	}
    end
end
