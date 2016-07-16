class User < ApplicationRecord
	attr_accessor :remember_token, :remember_digest
	before_create :create_remember_token
	has_many :posts

	has_secure_password
	validates :name, presence: true, length: {maximum: 50}
	validates :password, presence: true, length: {minimum: 6}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, 
					length: {maximum: 255},
					uniqueness: {case_sesitive: false},
					format: {with: VALID_EMAIL_REGEX}

	def User.new_token
		SecureRandom.urlsafe_base64
	end

	def remember
		self.remember_token = User.new_token
		self.remember_digest = Digest::SHA1.hexdigest(remember_token.to_s)
		update_attribute(:remember_digest, self.remember_digest)
	end

	def forget
		update_attribute(:remember_digest, nil)
	end

	def authenticated?(remember_token)
		return false if remember_digest.nil?
		#Bcrypt::Password.new(remember_digest).is_password?(remember_token)
		remember_digest == Digest::SHA1.hexdigest(remember_token.to_s)
	end

	def create_remember_token
		self.remember_token = User.new_token
		self.remember_digest = Digest::SHA1.hexdigest(self.remember_token.to_s)
	end
end
