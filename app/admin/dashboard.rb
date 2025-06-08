# frozen_string_literal: true

ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "🏆 Cybersport Arena Stats 🏆" do
          ul do
            li "🧑‍💻 Players: #{Player.count} — Who will be the next legend?"
            li "🤝 Teams: #{Team.count} — Teamwork makes the dream work!"
            li "🎲 Tournaments: #{Tournament.count} — May the odds be ever in your favor!"
            li "📊 Average Player Age: #{Player.average(:age)&.round(1) || 'N/A'}"
            li "👶 Youngest Player Age: #{Player.minimum(:age) || 'N/A'}"
            li "🧓 Oldest Player Age: #{Player.maximum(:age) || 'N/A'}"
            li "💰 Total Prizepool: #{Tournament.sum(:prizepool)}"
          end
        end

        panel "🕑 Recent Tournaments" do
          table_for Tournament.order(date: :desc).limit(5) do
            column("Name") { |t| t.name }
            column("Date") { |t| t.date }
            column("Prizepool") { |t| t.prizepool }
          end
        end

        panel "🏅 Top 5 Teams by World Ranking" do
          table_for Team.where.not(worldRanking: nil).order(:worldRanking).limit(5) do
            column("Rank") { |team| team.worldRanking }
            column("Name") { |team| team.name }
            column("Description") { |team| team.description }
          end
        end

        panel "🆕 Recently Joined Players" do
          table_for Player.order(created_at: :desc).limit(5) do
            column("Nickname") { |p| p.nickname }
            column("Real Name") { |p| p.realname }
            column("Age") { |p| p.age }
            column("Joined At") { |p| p.created_at.strftime("%Y-%m-%d") }
          end
        end

        panel "💎 Largest Prizepool Tournament" do
          tournament = Tournament.order(prizepool: :desc).first
          if tournament
            attributes_table_for tournament do
              row("Name") { tournament.name }
              row("Date") { tournament.date }
              row("Prizepool") { tournament.prizepool }
            end
          else
            span "No tournaments available."
          end
        end

        div style: "margin-top: 2em; font-size: 1.2em; color: #2c3e50;" do
          "🔥 Welcome to the Cybersport Admin Panel! Remember: behind every great team is a great admin. Keep clicking, keep winning! 🚀"
        end
      end
    end
  end
end
