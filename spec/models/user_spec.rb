require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#find_for_provider_oauth' do
    let(:access_token) do
      double(
        :access_token,
        provider: 'facebook',
        info: double(
          email: ENV["MY_FB_EMAIL"], 
          name: ENV["MY_FB_NAME"],
          image: ENV["MY_FB_IMAGE"]),
        extra: double(raw_info: double(id: ENV["MY_FB_ID"]))
      )
    end

    context 'when user is not found' do
      it 'returns newly created user' do
        user = User.find_for_provider_oauth(access_token)

        expect(user).to be_persisted
        expect(user.email).to eq ENV["MY_FB_EMAIL"]
      end
    end

    context 'when user is found by email' do
      let!(:existing_user) { FactoryBot.create(:user, email: ENV["MY_FB_EMAIL"]) }

      it 'returns this user' do
        expect(User.find_for_provider_oauth(access_token)).to eq existing_user
      end
    end

    context 'when user is found by provider + url' do
      let!(:existing_user) do
        FactoryBot.create(:user, provider: 'facebook', url: "https://facebook.com/#{ENV["MY_FB_ID"]}")
      end

      it 'returns this user' do
        expect(User.find_for_provider_oauth(access_token)).to eq existing_user
      end
    end
  end
end
