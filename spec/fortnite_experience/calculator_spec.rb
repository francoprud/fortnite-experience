RSpec.describe FortniteExperience::Calculator do
  subject { described_class.new(api_key) }

  let(:api_key)               { 'api_key' }
  let(:poi_uri)               { FortniteExperience::Services::FortniteAPI::POI_URI }
  let(:weekly_challenges_uri) { FortniteExperience::Services::FortniteAPI::WEEKLY_CHALLENGES_URI }

  describe '.experience_by_pois' do
    context 'when API key is valid' do
      context 'and daily request limit is not exceeded' do
        it 'returns the experience grouped by POIs' do
          stub_request(:get, poi_uri)
            .to_return(
              status: 200,
              body: File.read('spec/support/responses/fortniteapi.io/poi/valid.json'),
              headers: { 'Authorization' => api_key, 'Content-Type' => 'application/json' }
            )
          stub_request(:get, weekly_challenges_uri)
            .to_return(
              status: 200,
              body: File.read(
                'spec/support/responses/fortniteapi.io/weekly_challenges/valid.json'
              ),
              headers: { 'Authorization' => api_key, 'Content-Type' => 'application/json' }
            )

          expect(subject.experience_by_pois).to eq(
            'CRAGGY CLIFFS' => 50_000, 'CATTY CORNER'     => 25_000, 'DIRTY DOCKS'    => 25_000,
            'HOLLY HEDGES'  => 25_000, 'LAZY LAKE'        => 25_000, 'MISTY MEADOWS'  => 50_000,
            "DOOM'S DOMAIN" => 50_000, 'STEAMY STACKS'    => 50_000, 'RETAIL ROW'     => 25_000,
            'SALTY SPRINGS' => 25_000, 'THE AUTHORITY'    => 50_000, 'SLURPY SWAMP'   => 25_000,
            'SWEATY SANDS'  => 25_000, 'STARK INDUSTRIES' => 100_000, 'WEEPING WOODS' => 50_000
          )
        end
      end

      # TODO: verify response code for DailyRequestLimitExceededError
      context 'and daily request limit is exceeded' do
        xit 'raises a DailyRequestLimitExceededError' do
          expect { subject.experience_by_pois }
            .to raise_error(
              FortniteExperience::Services::FortniteAPI::DailyRequestLimitExceededError
            )
        end
      end
    end

    context 'when API key is not valid' do
      it 'raises a APIKeyNotValidError' do
        stub_request(:get, poi_uri)
          .to_return(
            status: 200,
            body: File.read('spec/support/responses/fortniteapi.io/poi/invalid_api_key.json'),
            headers: { 'Authorization' => api_key, 'Content-Type' => 'application/json' }
          )

        expect { subject.experience_by_pois }
          .to raise_error(FortniteExperience::Services::FortniteAPI::APIKeyNotValidError)
      end
    end
  end
end
