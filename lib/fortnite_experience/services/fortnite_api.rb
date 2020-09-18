require 'httparty'

module FortniteExperience
  module Services
    class FortniteAPI
      BASE_URL = -'https://fortniteapi.io'

      class << self
        def get_poi_names(api_key)
          uri = "#{BASE_URL}/game/poi?lang=en"
          HTTParty.get(uri, headers: { 'Authorization' => api_key })
                  .parsed_response['list'].map { |poi| poi['name'] }
        end

        def get_weekly_challenges(api_key)
          uri = "#{BASE_URL}/v1/challenges?season=current&lang=en"
          HTTParty.get(uri, headers: { 'Authorization' => api_key })
                  .parsed_response['weeks'].values.map { |week| week['challenges'] }.flatten
        end
      end
    end
  end
end
