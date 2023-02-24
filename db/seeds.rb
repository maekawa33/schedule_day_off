5.times {
  User.create!(
    name: Faker::Name.unique.name,
    email: Faker::Internet.unique.email,
		role: 0,
		password: 'password',
		password_confirmation: 'password',
		avatar: open("./app/assets/images/default_icon.png")
  )
}

User.all.each do |user|
  5.times {
    Schedule.create!(
      schedule_title: Faker::Alphanumeric.alpha(number: 10),
      assumed_number_people: Faker::Number.between(from:1, to:3),
      get_up_time: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now),
      sleep_time: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now),
      user: user,
    )
  }
end
  
Schedule.all.each do |schedule|
  5.times {
    Event.create!(
      start_time: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now),
      end_time: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now),
      event_title: Faker::Alphanumeric.alpha(number: 10),
      image: open("./app/assets/images/default_icon.png"),
      price: Faker::Number.between(from:1, to:10000),
      store: Faker::Internet.url,
      comment: Faker::Hobby.activity,
      three_main_events: true,
      schedule: schedule,
    )
  }
end

