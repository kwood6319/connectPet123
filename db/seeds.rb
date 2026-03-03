require 'open-uri'

puts "Cleaning database..."

# Wipes all data from the tables, resets auto-incrementing IDs, and bypasses foreign key constraints.
# Instead of asking Rails to destroy objects one by one, send a command directly to the database engine.
connection = ActiveRecord::Base.connection
# TRUNCATE: Removes all records from a table without processing each one individually(fast).
# RESTART IDENTITY: Clears all data, resets IDs to 1.
# CASCADE: Ignores link errors between tables.
connection.execute("TRUNCATE messages, logs, friendships, chats, pets, clinics, users RESTART IDENTITY CASCADE")


puts "Database cleaned! Creating new data..."

puts "Creating users..."
katie = User.create!(
  name: "Katie",
  email: "katie@owner.com",
  password: "password123",
  role: "owner"
)

renato = User.create!(
  name: "Renato",
  email: "renato@owner.com",
  password: "password123",
  role: "owner"
)

troy = User.create!(
  name: "Troy",
  email: "troy@owner.com",
  password: "password123",
  role: "owner"
)

vet01 = User.create!(
  name: "Patrick Gregory House",
  email: "patrick@vet.com",
  password: "password123",
  address: "123-4567 Tokyo, Meguro Higashi-Meguro 1-2-3",
  role: "vet"
)

vet02 = User.create!(
  name: "James Hetfield",
  email: "james@vet.com",
  password: "password123",
  address: "456-7890 Tokyo Machida, Kanamori 1-2-3",
  role: "vet"
)

vet03 = User.create!(
  name: "John Sykes",
  email: "john@vet.com",
  password: "password123",
  address: "234-5678 Kanagawa Yokohama, Kanai 1-2-3",
  role: "vet"
)

puts "Creating pets..."
raye = Pet.create!(
  user: katie,
  name: "Raye",
  dob: Date.new(2021, 8, 12),
  species: "Cat",
  breed: "Mixed black",
  weight: 4.8,
  vacc_status: "Vaccinated",
  fixed: true,
  gender: "Male",
  attr1: "Food",
  attr2: "Nausea",
  attr3: "Toilet",
  microchip: "111 111 111 111 111"
)

# cloudinary
raye_url = "https://res.cloudinary.com/rts1307/image/upload/v1771651747/development/reye.jpg"
raye.photo.attach(io: URI.open(raye_url), filename: "raye.jpg", content_type: "image/jpg")
raye.save!
puts "Raye created"

percy = Pet.create!(
  user: katie,
  name: "Percy",
  dob: Date.new(2021, 8, 12),
  species: "Cat",
  breed: "Mixed orange",
  weight: 5,
  vacc_status: "Vaccinated",
  fixed: true,
  gender: "Male",
  attr1: "Food",
  attr2: "Nausea",
  attr3: "Toilet",
  microchip: "111 111 111 111 112"
)

# cloudinary
percy_url = "https://res.cloudinary.com/rts1307/image/upload/v1771651750/development/percy.jpg"
percy.photo.attach(io: URI.open(percy_url), filename: "percy.jpg", content_type: "image/jpg")
percy.save!
puts "Percy created"

cory = Pet.create!(
  user: katie,
  name: "Cory",
  dob: Date.new(2024, 10, 22),
  species: "Cat",
  breed: "Mixed black",
  weight: 5.2,
  vacc_status: "Vaccinated",
  fixed: true,
  gender: "Male",
  attr1: "Food",
  attr2: "Toilet",
  microchip: "111 111 111 111 113"
)

# cloudinary
cory_url = "https://res.cloudinary.com/rts1307/image/upload/v1771651745/development/corey.jpg"
cory.photo.attach(io: URI.open(cory_url), filename: "cory.jpg", content_type: "image/jpg")
cory.save!
puts "Cory created"

big_tex = Pet.create!(
  user: katie,
  name: "Big Tex",
  dob: Date.new(2022, 5, 10),
  species: "Horse",
  breed: "Polamino",
  weight: 3.5,
  vacc_status: "Vaccinated",
  fixed: true,
  gender: "Female",
  attr1: "Food",
  attr2: "Toilet",
)

puts "Big Tex created"

jonathan = Pet.create!(
  user: katie,
  name: "Jonathan",
  dob: Date.new(2023, 1, 15),
  species: "Dragon",
  breed: "Western Red",
  weight: 4.2,
  vacc_status: "Vaccinated",
  fixed: true,
  gender: "Female",
  attr1: "Food",
  attr2: "Toilet",
)
puts "Jonathan created"

maple = Pet.create!(
  user: renato,
  name: "Maple",
  dob: Date.new(2025, 4, 30),
  species: "Dog",
  breed: "Toy poodle",
  weight: 4.5,
  vacc_status: "Vaccinated",
  fixed: false,
  gender: "Female"
)

# cloudinary
maple_url = "https://res.cloudinary.com/rts1307/image/upload/v1771497608/development/maple.png"
maple.photo.attach(io: URI.open(maple_url), filename: "maple.png", content_type: "image/png")
maple.save!
puts "Maple created"

gabby = Pet.create!(
  user: troy,
  name: "Gabby",
  dob: Date.new(2016, 5, 31),
  species: "Cat",
  breed: "Exotic shorthair",
  weight: 5,
  vacc_status: "Vaccinated",
  fixed: true,
  gender: "Male",
)

# cloudinary
gabby_url = "https://res.cloudinary.com/rts1307/image/upload/v1771659086/development/gabby.jpg"
gabby.photo.attach(io: URI.open(gabby_url), filename: "gabby.jpg", content_type: "image/jpg")
gabby.save!
puts "Gabby created"

jade = Pet.create!(
  user: troy,
  name: "Jade",
  dob: Date.new(2020, 4, 5),
  species: "Cat",
  breed: "Exotic shorthair",
  weight: 4,
  vacc_status: "Vaccinated",
  fixed: true,
  gender: "Female",
)

# cloudinary
jade_url = "https://res.cloudinary.com/rts1307/image/upload/v1771659087/development/jade.jpg"
jade.photo.attach(io: URI.open(jade_url), filename: "jade.jpg", content_type: "image/jpg")
jade.save!
puts "Jade created"

puts "Making clinics"

lewagon = Clinic.create!(
  field: ["cardiology", "dentist"],
  clinic_name:"Le Wagon Pet Clinic",
  contact: "contact@pet_forest.com",
  species: ["cats", "dogs", "horses"],
  user: vet01
  )

# cloudinary
lewagon_url = "https://res.cloudinary.com/rts1307/image/upload/v1772466537/development/LewagonPetClinic.png"
lewagon.photo.attach(io: URI.open(lewagon_url), filename: "lewagon.png", content_type: "image/png")
lewagon.save!
puts "Le Wagon Clinic created"

sos_pet = Clinic.create!(
  field: ["Oncology","surgery"],
  clinic_name:"SOS Pet",
  contact: "contact@sospet.com",
  species: ["cats", "dogs", "birds"],
  user: vet02
  )

# cloudinary
sos_pet_url = "https://res.cloudinary.com/rts1307/image/upload/v1772466538/development/SOSpet.png"
sos_pet.photo.attach(io: URI.open(sos_pet_url), filename: "sos_pet.png", content_type: "image/png")
sos_pet.save!
puts "SOS Pet Clinic created"

pet_protect = Clinic.create!(
  field: ["Oncology"],
  clinic_name:"PetProtect",
  contact: "contact@petprotect.com",
  species: ["cats", "dogs", "birds"],
  user: vet03
  )

  # cloudinary
pet_protect_url = "https://res.cloudinary.com/rts1307/image/upload/v1772466539/development/PetProtect.png"
pet_protect.photo.attach(io: URI.open(pet_protect_url), filename: "pet_protect.png", content_type: "image/png")
pet_protect.save!
puts "Pet Protect Clinic created"

puts "Finished making clinics"

puts "Creating logs for Raye"

Log.create!(pet: raye,
  attr1: "Food", attr1_value: "3", attr1_memo: "50g",
  attr2: "Nausea", attr2_value: "", attr2_memo: "Threw up in the cat room!",
  attr3: "Toilet", attr3_value: "", attr3_memo: "Poop in the morning",
  date: Date.parse("2026-02-10"))

Log.create!(pet: raye,
  attr1: "Food", attr1_value: "4", attr1_memo: "45g",
  attr2: "Nausea", attr2_value: "0", attr2_memo: "",
  attr3: "Toilet", attr3_value: "", attr3_memo: "Poop in the morning!",
  date: Date.parse("2026-02-20"))

Log.create!(pet: raye,
  attr1: "Food", attr1_value: "3", attr1_memo: "45g",
  attr2: "Nausea", attr2_value: "0", attr2_memo: "Threw up in the cat room again!",
  attr3: "Toilet", attr3_value: "", attr3_memo: "Poop in the morning!",
  date: Date.yesterday)

Log.create!(pet: maple,
  attr1: "Food", attr1_value: "3", attr1_memo: "45g",
  attr2: "Nausea", attr2_value: "0", attr2_memo: "",
  attr3: "Toilet", attr3_value: "", attr3_memo: "Poop in the morning!",
  date: Date.parse("2026-02-23"))

puts "Created #{Log.count} logs"


puts "Finished! Created #{User.count} users and #{Pet.count} pets."

puts "Creating chats..."

chat1 = Chat.create!(
  owner: katie,
  vet: vet01,
  pet: raye,
  archived: false
)

chat2 = Chat.create!(
  owner: renato,
  vet: vet01,
  pet: maple,
  archived: false
)

chat3 = Chat.create!(
  owner: katie,
  vet: vet01,
  pet: percy,
  archived: false
)

# puts "Creating friendship"

# friendship1 = Friendship.create!(
#   owner: katie,
#   vet: vet01
# )

# friendship2 = Friendship.create!(
#   owner: renato,
#   vet: vet01
# )

# friendship3 = Friendship.create!(
#   owner: katie,
#   vet: vet01
# )

puts "Creating messages..."

# Chat 1 conversation
Message.create!(chat: chat1, user: katie, contents: "Hello Doctor, Raye has been heaving.")
Message.create!(chat: chat1, user: vet01, contents: "How long has this been happening?")
Message.create!(chat: chat1, user: katie, contents: "About two days.")
Message.create!(chat: chat1, user: vet01, contents: "Any changes in appetite?")
Message.create!(chat: chat1, user: katie, contents: "No, appetite is normal.")
Message.create!(chat: chat1, user: vet01, contents: "Please bring Raye in tomorrow at 10am.")

# Chat 2 conversation
Message.create!(chat: chat2, user: renato, contents: "Hi Doctor, Maple is not eating much.")
Message.create!(chat: chat2, user: vet01, contents: "Has she been vomiting?")
Message.create!(chat: chat2, user: renato, contents: "No vomiting, just low appetite.")
Message.create!(chat: chat2, user: vet01, contents: "Let's schedule a checkup this week.")
Message.create!(chat: chat2, user: renato, contents: "Thank you, that would be great.")

# Chat 4 conversation
Message.create!(chat: chat3, user: katie, contents: "Percy hasn't been going toilet very often")
Message.create!(chat: chat3, user: vet01, contents: "That's concerning. Any other symptoms?")
Message.create!(chat: chat3, user: katie, contents: "His appetite is a little low.")
Message.create!(chat: chat3, user: vet01, contents: "Alright, let's make an appointment for tomorrow. How is 3pm?")
Message.create!(chat: chat3, user: katie, contents: "Perfect. Thank you.")

puts "Finished! Created #{User.count} users, #{Pet.count} pets, #{Clinic.count} clinics, #{Log.count} logs, and #{Chat.count} chats with #{Message.count} messages."
