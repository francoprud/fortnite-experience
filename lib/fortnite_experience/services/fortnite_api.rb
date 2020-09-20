require 'httparty'

module FortniteExperience
  module Services
    class FortniteAPI
      class DailyRequestLimitExceededError < StandardError; end
      class APIKeyNotValidError < StandardError; end

      BASE_URL = -'https://fortniteapi.io'

      class << self
        def get_poi_names(api_key)
          uri = "#{BASE_URL}/game/poi?lang=en"
          response = HTTParty.get(uri, headers: { 'Authorization' => api_key })
          verify(response)
          response.parsed_response['list'].map { |poi| poi['name'] }
        end

        def get_weekly_challenges(api_key)
          uri = "#{BASE_URL}/v1/challenges?season=current&lang=en"
          response = HTTParty.get(uri, headers: { 'Authorization' => api_key })
          verify(response)
          response.parsed_response['weeks'].values.map { |week| week['challenges'] }.flatten
        end

        private

        def verify(response)
          raise APIKeyNotValidError if response['code'] == 'INVALID_API_KEY'
          # TODO: verify resonse code for DailyRequestLimitExceededError
          raise DailyRequestLimitExceededError if response['code'] == 'TBD'
        end
      end
    end
  end
end
