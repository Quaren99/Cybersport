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
    description: Faker::Lorem.sentence(word_count: 10),
    worldRanking: worldRanking
  )
end

def create_tournament
  prizepool = rand(1000..1000000)
  date = Faker::Date.between(from: 6.year.ago, to: Date.today + 1.year)
  t = Tournament.create!(
      name: Faker::Sports::Football.unique.competition,
      date: date,
      prizepool: prizepool
    )
    8.times do |i|
      if date > Date.today
        create_participant(nil, nil, t)
      else
        create_participant(i + 1, prizepool / ((i + 1)* 2), t)
      end
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

def create_team_members(team)
  team_start = Faker::Date.between(from: 10.years.ago, to: 5.years.ago)
  team_end = Date.today + 1.year

  5.times do
    current_start = team_start
    while current_start < team_end
      min_left = current_start + 6.months
      max_left = [ current_start + 3.years, team_end ].min
      left = [ true, false ].sample ? Faker::Date.between(from: min_left, to: max_left) : nil
      left = nil if left && left > team_end
      Member.create!(
        player: Player.all.sample,
        team: team,
        joined: current_start,
        left: left
      )
      break unless left
      current_start = left
    end
  end
end

100.times do
  create_player
end

20.times do |i|
  create_team(i + 1)
end

Team.all.each do |team|
  create_team_members(team)
end

20.times do
  create_tournament
end
