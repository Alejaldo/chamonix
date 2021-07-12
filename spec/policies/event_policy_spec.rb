require 'rails_helper'

describe EventPolicy do
  subject { described_class }

  let(:user) { FactoryBot.create(:user) }
  let(:no_pincode_event) { FactoryBot.create(:event, user: user) }
  let(:pincode_event) { FactoryBot.create(:event, user: user, pincode: 'Dadzhal') }
  let(:cookies) { { "events_#{pincode_event.id}_pincode" => 'Dadzhal' } }

  describe 'creator of event' do
    let(:event_creator) { UserContext.new(user, {}) }

    permissions :edit?, :update?, :destroy? do
      it { is_expected.to permit(event_creator, no_pincode_event) }
    end
    permissions :show? do
      it { is_expected.to permit(event_creator, pincode_event) }
    end
  end

  describe 'new registred user but not event owner' do
    let(:new_user) { FactoryBot.create(:user) }
    let(:new_user_has_no_pincode) { UserContext.new(new_user, {}) }
    let(:new_user_has_pincode) { UserContext.new(new_user, cookies) }

    permissions :edit?, :update?, :destroy? do
      it { is_expected.not_to permit(new_user_has_no_pincode, no_pincode_event) }
    end
    permissions :show? do
      it { is_expected.not_to permit(new_user_has_no_pincode, pincode_event) }
    end
    permissions :show? do
      it { is_expected.to permit(new_user_has_pincode, pincode_event) }
    end
  end

  describe 'new non-registred user' do
    let(:non_registred_user) { UserContext.new(nil, cookies) }

    permissions :edit?, :update?, :destroy? do
      it { is_expected.not_to permit(non_registred_user, no_pincode_event) }
    end
    permissions :show? do
      it { is_expected.to permit(non_registred_user, pincode_event) }
    end
  end
end
