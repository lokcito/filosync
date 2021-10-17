class DataFile < ApplicationRecord
  belongs_to :users, class_name: "User"
	
	validates :columns, 
		:filename, presence: true
		
	validates_format_of :filename, 
		:with => %r{\.(csv)\z}i, 
		:message => "The must be a CSV file."

	def get_n_rows
		return self.get_n_valid_rows + self.get_n_issued_rows
	end
	def get_n_valid_rows
		Contact.where(data_files: self).count
	end
	def get_n_issued_rows
		IssueFile.where(data_files: self).count
	end
	def self.get_namefile_to_store
		return "#{Time.zone.now.strftime("%F-%T")}.csv".gsub(":", "-")
	end

	def self.get_path_to_store(filename)
		return Rails.root.join('tmp', 'storage', "#{filename}")
	end

  def self.static_columns
  	return ["name", "email", 
    "address", "creditcard", "phone", 
    "franchise", "dateofbirth"]
  end

	def sync
		i = 1
		CSV.foreach(DataFile.get_path_to_store(self.filename)) do |z|
		  cc = {
		  	data_files_id: self.id
		  }
      self.columns.split("|").each_with_index do |t, i|
        case t
  		    when "name"
      		  cc[:name] = z[i]
  		    when "address"
      		  cc[:address] = z[i]
  		    when "dateofbirth"
      		  cc[:date_of_birth] = z[i]
  		    when "phone"
      		  cc[:phone] = z[i]
  		    when "email"
      		  cc[:email] = z[i]
  		    when "creditcard"
      		  cc[:credit_card] = z[i]
  		    when "franchise"
      		  cc[:franchise] = z[i]
        end
      end

      new_contact = Contact._create(cc)
      unless new_contact[:error].blank?
        IssueFile._create({
        	data_files_id: self.id,
        	data_row: z.join(","),
        	line: i,
        	issues: new_contact[:error].errors.full_messages.to_sentence
        })
      end
      i += 1
		end
		
		if Contact.where(data_files: self).count <= 0
			if IssueFile.where(data_files: self).count > 0
				self.mark_as("failed")
				return
			end
		end
		self.mark_as("finished")
	end

	def mark_as(_status)
		self.status = _status
		if self.valid? and self.save()
		  return {
			  object: self
		  }
		end
		return {
		  error: self
		}		
	end
	
	def self._create(opts)
		o = DataFile.new
		o.users_id = opts[:user_id]
		o.s3_path = ""
		o.status = "hold"
		o.columns = opts[:columns]
		o.filename = opts[:filename]
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