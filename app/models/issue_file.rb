class IssueFile < ApplicationRecord
  belongs_to :data_files, class_name: "DataFile"
	validates :line, 
		:issues,
		:data_files, presence: true
		
  def self._create(opts)
	o = IssueFile.new
	o.data_files_id = opts[:data_files_id]
	o.data_row = opts[:data_row]
	o.issues = opts[:issues]
	o.line = opts[:line]
	if o.valid? and o.save()
	  return {
		  object: o
	  }
	end
	return {
	  error: o
	}
  end
end
