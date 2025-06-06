def create_player
  Player.create!(
    nickname: Faker::Internet.unique.username,
    realname: Faker::Name.name,
    age: rand(18..35)
  )
end
def create_team(worldRanking)
  Team.create!(
    name: Faker::Sports::Football.unique.team,
    worldRanking: worldRanking
  )
end
def create_member
  joined_date = Faker::Date.between(from: 10.years.ago, to: Date.today)
  left_date = nil

  if [ true, false ].sample && rand > 0.4
    left_date = Faker::Date.between(from: joined_date + 1.month, to: joined_date + 8.years)
  end
  Member.create!(
    player: Player.all.sample,
    team: Team.all.sample,
    joined: joined_date,
    left: left_date
  )
end

def create_tournament
  prizepool = rand(1000..1000000)
  t = Tournament.create!(
      name: Faker::Sports::Football.unique.competition,
      date: Faker::Date.between(from: 6.year.ago, to: Date.today),
      prizepool: prizepool
    )
    8.times do |i|
      create_participant(i + 1, prizepool / ((i + 1)* 2), t)
    end
end

def create_participant(place, prize, tournament)
    Participant.create!(
      tournament: tournament,
      team: Team.all.sample,
      place: place,
      prize: prize
    )
end

100.times do
  create_player
end

20.times do |i|
  create_team(i + 1)
end

200.times do
  create_member
end

20.times do
  create_tournament
end
