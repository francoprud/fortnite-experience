require 'httparty'

module FortniteExperience
  module Services
    class FortniteAPI
      class DailyRequestLimitExceededError < StandardError; end
      class APIKeyNotValidError < StandardError; end

      BASE_URI              = -'https://fortniteapi.io'
      POI_URI               = -"#{BASE_URI}/game/poi?lang=en"
      WEEKLY_CHALLENGES_URI = -"#{BASE_URI}/v1/challenges?season=current&lang=en"

      class << self
        def get_poi_names(api_key)
          response = HTTParty.get(POI_URI, headers: { 'Authorization' => api_key })
          verify(response)
          response.parsed_response['list'].map { |poi| poi['name'] }
        end

        def get_weekly_challenges(api_key)
          response = HTTParty.get(WEEKLY_CHALLENGES_URI, headers: { 'Authorization' => api_key })
          verify(response)
          response.parsed_response['weeks'].values.map { |week| week['challenges'] }.flatten
        end

        private

        def verify(response)
          raise APIKeyNotValidError if response['code'] == 'INVALID_API_KEY'
          # TODO: verify response code for DailyRequestLimitExceededError
          raise DailyRequestLimitExceededError if response['code'] == 'TBD'
        end
      end
    end
  end
end
