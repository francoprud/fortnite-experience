RSpec.describe FortniteExperience::Calculator do
  subject(:validator) { described_class.new('api_key') }

  describe '.experience_by_pois' do
    context 'when API key is valid' do
      context 'and daily request limit is not exceeded' do
        xit 'returns the experience grouped by POIs' do
        end
      end

      context 'and daily request limit is exceeded' do
        xit 'raises a DailyRequestLimitExceededError' do
          expect { validator.experience_by_pois }
            .to raise_error(
              FortniteExperience::Services::FortniteAPI::DailyRequestLimitExceededError
            )
        end
      end
    end

    context 'when API key is not valid' do
      it 'raises a APIKeyNotValidError' do
        expect { validator.experience_by_pois }
          .to raise_error(FortniteExperience::Services::FortniteAPI::APIKeyNotValidError)
      end
    end
  end
end
