#By Marcel Zak

require 'openssl'

class User < ApplicationRecord
	validates :first_name, :presence => true, length: {maximum: 255}
	validates :last_name, :presence => true, length: {maximum: 255}
	validates :nick_name, :presence => true, :uniqueness => true, length: {maximum: 20}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email_address, :presence => true, :uniqueness => {case_sensitive: false}, format: { with: VALID_EMAIL_REGEX }, length: {maximum: 255}
	validates :password, :confirmation => true, length: {minimum: 8}
	validate :password_must_be_present
	attr_reader :password 	#virtual attribute

	# using PBKDF2 (Password-Based Key Derivation Function 2)
	# https://ruby-doc.org/stdlib-2.0.0/libdoc/openssl/rdoc/OpenSSL/PKCS5.html
	def User.hash_password(password, salt)
		digest = OpenSSL::Digest::SHA256.new
		saltted_password = OpenSSL::PKCS5.pbkdf2_hmac(password + "my_awesome_pepper", salt, 100_000, 32, digest)
		saltted_password.unpack('H*')[0]
	end
	
	
	def password=(password)
		@password = password
		
		if password.present?
			generate_salt
			self.hashed_password = self.class.hash_password(password, salt)
		end
	end
	
	def User.authenticate(email_address, password)
		if user = find_by_email_address(email_address)
			if eql_time_cmp(user.hashed_password, hash_password(password, user.salt))
				user
			end
		end
	end

	protected
	#The proper way is to use a method that always takes the same amount of time 
	#when comparing two values, thus not leaking any information to potential attackers.
	def User.eql_time_cmp(a, b)
	  unless a.length == b.length
	    return false
	  end
	  cmp = b.bytes.to_a
	  result = 0
	  a.bytes.each_with_index {|c,i|
	    result |= c ^ cmp[i]
	  }
	  result == 0
	end
	
	private
	
	def password_must_be_present
		errors.add(:password, "Missing Password") unless hashed_password.present?
	end
	
	def generate_salt
		salt = OpenSSL::Random.random_bytes(32)
		self.salt = salt.unpack('H*')[0]
	end	
end
