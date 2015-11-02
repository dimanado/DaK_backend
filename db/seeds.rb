User.where(email: 'testlecturer@mail.ru').first_or_create(password: '123456789', provider: 'email')
user = User.find_by(email: 'testlecturer@mail.ru')
user.add_role :lecturer
user.confirm!
user.save

User.where(email: 'testuser@mail.ru').first_or_create(password: '123456789', provider: 'email')
userSecond = User.find_by(email: 'testuser@mail.ru')
userSecond.add_role :user
userSecond.confirm!
userSecond.save