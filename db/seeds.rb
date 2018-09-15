Admin.create(email: 'dak@gmail.com', password: BCrypt::Password.create("12345"))
User.create(email: 'vasia@gmail.com', password: "12345", name: "Vasia")
User.create(email: 'petiamail.com', password: "12345", name: "Petia")
User.create(email: 'dima@gmail.com', password: "12345", name: "Dima")
User.create(email: 'tania@gmail.com', password: "12345", name: "Tania")
User.create(email: 'vania@gmail.com', password: "12345", name: "Vania")
User.create(email: 'andrei@gmail.com', password: "12345", name: "Andrei")

# User.where(email: 'testlecturer@mail.ru', nickname: 'lecturer').first_or_create(password: '123456789', provider: 'email')
# user = User.find_by(email: 'testlecturer@mail.ru')
# user.add_role :lecturer
# user.confirm!
# user.save
#
# User.where(email: 'testuser@mail.ru', nickname: 'Katya').first_or_create(password: '123456789', provider: 'email')
# userSecond = User.find_by(email: 'testuser@mail.ru')
# userSecond.add_role :user
# userSecond.confirm!
# userSecond.save

#User.where(email: 'testlecturer1@mail.ru', nickname: 'lecturer1').first_or_create(password: '123456789', #provider: 'email')
#user = User.find_by(email: 'testlecturer1@mail.ru')
#user.add_role :lecturer
#user.confirm!
#user.save

# User.where(email: 'testuser2@mail.ru', nickname: 'Alexandr').first_or_create(password: '123456789', provider: 'email')
# userSecond = User.find_by(email: 'testuser2@mail.ru')
# userSecond.add_role :user
# userSecond.confirm!
# userSecond.save

Category.create( name: 'Математика')
Category.create( name: 'Компьютерные науки')
Category.create( name: 'Логика')
Category.create( name: 'Физика')
Category.create( name: 'Химия')
Category.create( name: 'Искусство')
Category.create( name: 'Другое')
