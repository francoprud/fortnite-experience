RSpec.describe FortniteExperience::Services::FortniteAPI do
  let(:api_key)               { 'api_key' }
  let(:poi_uri)               { FortniteExperience::Services::FortniteAPI::POI_URI }
  let(:weekly_challenges_uri) { FortniteExperience::Services::FortniteAPI::WEEKLY_CHALLENGES_URI }

  describe 'self.get_poi_names' do
    subject { described_class.get_poi_names(api_key) }

    context 'when API key is valid' do
      context 'and daily request limit is not exceeded' do
        it 'returns the experience grouped by POIs' do
          stub_request(:get, poi_uri)
            .to_return(
              status: 200,
              body: File.read('spec/support/responses/fortniteapi.io/poi/valid.json'),
              headers: { 'Authorization' => api_key, 'Content-Type' => 'application/json' }
            )

          expect(subject).to eq(
            ['CRAGGY CLIFFS', 'CORAL CASTLE', 'CATTY CORNER', 'DIRTY DOCKS', 'THE FORTILLA',
             'HOLLY HEDGES', 'LAZY LAKE', 'MISTY MEADOWS', "DOOM'S DOMAIN", 'STEAMY STACKS',
             'RETAIL ROW', 'SALTY SPRINGS', 'THE AUTHORITY', 'SLURPY SWAMP', 'SWEATY SANDS',
             'STARK INDUSTRIES', 'WEEPING WOODS']
          )
        end
      end

      # TODO: verify response code for DailyRequestLimitExceededError
      context 'and daily request limit is exceeded' do
        xit 'raises a DailyRequestLimitExceededError' do
          expect { subject }
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

        expect { subject }
          .to raise_error(FortniteExperience::Services::FortniteAPI::APIKeyNotValidError)
      end
    end
  end

  describe 'self.get_weekly_challenges' do
    subject { described_class.get_weekly_challenges(api_key) }

    context 'when API key is valid' do
      context 'and daily request limit is not exceeded' do
        it 'returns the experience grouped by POIs' do
          stub_request(:get, weekly_challenges_uri)
            .to_return(
              status: 200,
              body: File.read(
                'spec/support/responses/fortniteapi.io/weekly_challenges/valid.json'),
              headers: { 'Authorization' => api_key, 'Content-Type' => 'application/json' }
            )

          expect(subject).to eq(
            YAML.load_file('spec/support/responses/fortnite_api/get_weekly_challenges.yml')
          )
        end
      end

      # TODO: verify response code for DailyRequestLimitExceededError
      context 'and daily request limit is exceeded' do
        xit 'raises a DailyRequestLimitExceededError' do
          expect { subject }
            .to raise_error(
              FortniteExperience::Services::FortniteAPI::DailyRequestLimitExceededError
            )
        end
      end
    end

    context 'when API key is not valid' do
      it 'raises a APIKeyNotValidError' do
        stub_request(:get, weekly_challenges_uri)
          .to_return(
            status: 200,
            body: File.read(
              'spec/support/responses/fortniteapi.io/weekly_challenges/invalid_api_key.json'),
            headers: { 'Authorization' => api_key, 'Content-Type' => 'application/json' }
          )

        expect { subject }
          .to raise_error(FortniteExperience::Services::FortniteAPI::APIKeyNotValidError)
      end
    end
  end
end
