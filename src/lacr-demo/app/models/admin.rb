class Admin < Patron
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable
	def decrement_invitation_limit!
    	#stub functionality because devise invitation call this method to decrement the counter.
  	end
end
