
  User.create!(
    name: 'ニックネーム',
    email: Faker::Internet.unique.email,
		role: 0,
		password: 'password',
		password_confirmation: 'password',
		avatar: open("./app/assets/images/default_icon.png")
  )

User.all.each do |user|
  Schedule.create!(
    schedule_title: '休日',
    assumed_number_people: 1,
    get_up_time: '07:00',
    sleep_time: '22:00',
    user: user,
  )
end
  
Schedule.all.each do |schedule|
  Event.create!(
    start_time: '09:00',
    end_time: '12:00',
    event_title: 'カフェでプログラミング',
    image: open("./app/assets/images/programing.png"),
    price: 500,
    store: '',
    comment: 'RUNTEQでプログラミング学習',
    schedule: schedule,
  )
  Event.create!(
    start_time: '12:15',
    end_time: '12:45',
    event_title: '行きつけのラーメン屋に行く',
    image: open("./app/assets/images/ramen.png"),
    price: 1000,
    store: '',
    comment: '',
    schedule: schedule,
  )
  Event.create!(
    start_time: '18:00',
    end_time: '21:00',
    event_title: 'サウナで整う',
    image: open("./app/assets/images/sauna.png"),
    price: 1000,
    store: '',
    comment: '',
    schedule: schedule,
  )
end

