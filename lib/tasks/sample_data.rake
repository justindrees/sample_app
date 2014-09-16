namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do
		admin = User.create!(name: "Example User",
					email: "styrelsen@example.com",
					password: "foobar",
					password_confirmation: "foobar",
					admin: true)

		99.times do |n|
			name = Faker::Name.name
			email = "example-#{n+1}@example.com"
			password = "password"
			User.create!(name: name,
						 email: email,
						 password: password,
						 password_confirmation: password)
		end

		user = User.find_by(email: "styrelsen@example.com")
		50.times do
			title = "Test Title"
			content = Faker::Lorem.sentence(5)
			user.microposts.create!(title: title, content: content)
		end
	end
end