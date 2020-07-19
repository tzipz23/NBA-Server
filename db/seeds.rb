# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])

#   Character.create(name: 'Luke', movie: movies.first)

require 'rest-client'

# APIs

TEAM_API_KEY = ENV['team_api_key']

User.destroy_all
Team.destroy_all
Player.destroy_all

user1 = User.create(first_name:'Tomazye', last_name:'Anderson', user_name:'tzipz', password:'z')

teams = RestClient.get(TEAM_API_KEY)
teams_array = JSON.parse(teams)["conferences"]
teams_array.each do |conference|
    conference["divisions"].each do |division|
        division["teams"].each do |team|
            url = ""
            teamsAbbreviation = {
                atl: 'hawks',
                bkn: 'nets',
                bos: 'celtics',
                cha: 'hornets',
                chi: 'bulls',
                cle: 'cavaliers',
                dal: 'mavericks',
                den: 'nuggets',
                det: 'pistons',
                gsw: 'warriors',
                hou: 'rockets',
                ind: 'pacers',
                lac: 'clippers',
                lal: 'lakers',
                mem: 'grizzlies',
                mia: 'heat',
                mil: 'bucks',
                min: 'timberwolves',
                nop: 'pelicans',
                nyk: 'knicks',
                okc: 'thunder',
                orl: 'magic',
                phi: '76ers',
                phx: 'suns',
                por: 'trail blazers',
                sac: 'kings',
                sas: 'spurs',
                tor: 'raptors',
                uta: 'jazz',
                was: 'wizards'
              }

            teamsAbbreviation.each do |abbreviation|
                url = "http://i.cdn.turner.com/nba/nba/.element/img/1.0/teamsites/logos/teamlogos_500x500/#{abbreviation[0]}.png" if team["name"].downcase === abbreviation[1]
            end

            Team.create(
                name: team["name"],
                market: team["market"],
                alias: team["alias"],
                venue: team["venue"]["name"],
                url_reference: team["id"],
                image: url,
                sport_title: "NBA",
                team_reference: team["reference"]
            )
        end
    end
end

# NBA players API seed data
raw_players = RestClient.get("http://data.nba.net/10s/prod/v1/2019/players.json")
new_team = JSON.parse(raw_players)["league"]

#Image API
otherAPI = RestClient.get("https://raw.githubusercontent.com/alexnoob/BasketBall-GM-Rosters/master/2019-20.NBA.Roster.json")
images = JSON.parse(otherAPI)

new_team["standard"].each do |player|
    image = ""
    images["players"].filter do |x|
        image = x["imgURL"] if x["name"] === "#{player['firstName']} #{player['lastName']}"
    end

if image === ""
    image = "https://alumni.crg.eu/sites/default/files/default_images/default-picture_0_0.png"
end

teams = Team.all
team_id = "".to_i
teams.filter do |team|
    team_id = team.id if team["team_reference"] === player["teamId"]
end

Player.create(
    full_name: "#{player['firstName']} #{player['lastName']}",
    real_team_id: player["teamId"],
    jersey_number: player["jersey"],
    position: player["pos"],
    height: "#{player['heightFeet']}'#{player['heightInches']}",
    weight: player["weightPounds"],
    birthdate: player["dateOfBirthUTC"],
    college: player["collegeName"],
    player_image: image,
    team_draft_id: player["draft"]["teamId"],
    league: "NBA",
    team_id: team_id
    )
end


