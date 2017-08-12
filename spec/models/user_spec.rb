require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation' do
    it { is_expected.to validate_presence_of :first_name }
    it { is_expected.to validate_presence_of :last_name }

    describe "Email format" do
      let!(:user) { User.new(email: 'aaa@aaa') }

      it 'Email is invalid' do
        user.validate
        expect(user.errors.messages).to include(email: ["is invalid"])
      end
    end
  end
end
