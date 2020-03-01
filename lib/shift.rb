require_relative 'key'
require_relative 'dated'

class Shift

  def alphabet
    ("a".."z").to_a << " "
  end

  def final_shift_key
    key = Key.new
    dated = Dated.new
    hash = {}
    key.transform_key(key.generate_random_key).map do |keys, value|
      total = dated.transform_date(dated.current_date)[keys]
      if total != nil
        hash[keys] = value.to_i + total.to_i
      end
    end
    hash
  end
end
# final_total_won_games = {}
# winning_game_ids(team_id).map do |key, value|
#   total_games = total_games_by_season(team_id)[key]
#   if total_games != nil
#     final_total_won_games[key] = ((value.to_f / total_games) * 100).round(2)
#   end
# end
# final_total_won_games