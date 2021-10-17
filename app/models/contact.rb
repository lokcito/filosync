class Contact < ApplicationRecord
	belongs_to :data_files, class_name: "DataFile"
	validates :name, 
		:franchise, 
		:email,
		:address,
		:phone,
		:credit_card,
		:date_of_birth, presence: true
	validates :email, email: true
	validates :email, uniqueness: true
	validates :franchise, 
		inclusion: { in: ['American Express', 
			'Diners Club', 'Discover',
			'JCB', 
			'MasterCard',
			'Visa'],
    message: "%{value} is not a Franchise." }
	validates :credit_card, 
		credit_card_number: {brands: [
			:amex, :diners, 
			:discover, 
			:jcb, 
			:mastercard, 
			:visa]}
	validates_format_of :name, 
		:with => /\A([\w\-\ ]{0,})\z/i, 
		:message => "Special characters are no allowed."
	validates_format_of :date_of_birth, 
		:with => /\A(([0-9]{4})-?(1[0-2]|0[1-9])-?(3[01]|0[1-9]|[12][0-9]))\z/i, 
		:message => "Please use ISO 8601."
	
	validates_format_of :phone, 
		:with => /\A(\(\+([0-9]){2}\)(\ |\-)[0-9]{3}(\ |\-)[0-9]{3}(\ |\-)[0-9]{2}(\ |\-)[0-9]{2}(\ |\-)?([0-9]{2})?)\z/i,
		:message => "Please use the follow format: (+00) 000 000 00 00 00"
	validate :credit_card_matchs_franchise
	
	def self._create(opts)
		o = Contact.new
		o.data_files_id = opts[:data_files_id]
		o.email = opts[:email]
		o.name = opts[:name]
		o.date_of_birth = opts[:date_of_birth]
		o.franchise = opts[:franchise]
		o.credit_card = opts[:credit_card]
		o.address = opts[:address]
		o.phone = opts[:phone]

		if o.valid? and o.save()
		  return {
			  object: o
		  }
		end
		return {
			error: o
		}
	end

	def _check(opts)
		o = Contact.new
		o.email = opts[:email]
		o.name = opts[:name]
		o.date_of_birth = opts[:date_of_birth]
		o.franchise = opts[:franchise]
		o.credit_card = opts[:credit_card]
		o.address = opts[:address]
		o.phone = opts[:phone]

		if o.valid?
		  return {
			  object: o
		  }
		end
		return {
			error: o
		}
	end
	
	private
		def credit_card_matchs_franchise
			if self.franchise.blank? or self.credit_card.blank?
				return
			end
			detector = CreditCardValidations::Detector.new(self.credit_card)
			errors.add(:credit_card, 
				'Credit Card and Franchise does not match.') unless detector
					.valid?(self.franchise)
		end
end
