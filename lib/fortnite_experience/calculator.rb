module FortniteExperience
  class Calculator
    def initialize(api_key)
      @api_key = api_key
    end

    def experience_by_pois
      result = {}

      Services::FortniteAPI.get_poi_names(@api_key).each do |poi|
        Services::FortniteAPI.get_weekly_challenges(@api_key).each do |challenge|
          if challenge['title'].match?(/#{poi}/i)
            result[poi] = (result[poi] || 0) + challenge['xp']
          end
        end
      end

      result
    end
  end
end
