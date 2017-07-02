class User < ActiveRecord::Base

	has_many :announcments  # user_id field in announcments will default to null if a user is deleted

	attr_accessor :password

	attr_protected :is_admin, :password_hash, :password_salt

	before_save :encrypt_password

	validates_confirmation_of :password
	validates_presence_of :password, :on => { :create, :update }
	validates_presence_of  :email
	validates_uniqueness_of :email

	def send_password_reset
		generate_token(:password_reset_token)
		self.password_reset_sent_at = Time.zone.now
		save!
		UserMailer.password_reset(self).deliver
	end

	def generate_token(column)
		begin
			self[column] = SecureRandom.base64.tr("+/", "-_") #urlsafe hack for rails 3.0.x
		end while User.exists?(column => self[column])
	end

	def self.all_admins
		self.where("is_admin = ?", true)
	end

	def self.all_standard
		self.where("is_admin = ?", false)
	end

	def self.authenticate(email, password)
		user = find_by_email(email)
		if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
			user
		else
			nil
		end
	end

	def encrypt_password
		if password.present?
			self.password_salt = BCrypt::Engine.generate_salt
			self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
		end
	end

	def full_name
		self.first_name + " " + self.last_name
	end
end
