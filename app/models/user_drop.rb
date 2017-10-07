class UserDrop < Liquid::Drop
	def initialize(args)
		@user = args
	end
	
	def name
		@user["name"]
	end

	def email
		@user["email"]
	end

	def contact
		@user["contact"]
	end

	def expertise
		@user["expertise"]
	end

	def dob
		@user["dob"]
	end

	def id
		@user["id"]
	end

	def picture
		@user["picture"]
	end
end
