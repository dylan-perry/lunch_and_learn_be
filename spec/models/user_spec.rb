require 'rails_helper'

RSpec.describe User, type: :model do
    describe 'validations' do
      it { should validate_presence_of(:name)}
      it { should validate_presence_of(:email)}
      it { should allow_value('user@example.com').for(:email) }
      it { should_not allow_value('invalid_email').for(:email) }
      it { should validate_presence_of(:password_digest)}

      it "ensures email uniqueness case insensitively" do
        user1 = User.create!(name: "Miss Frizzle", email: "thefrizz@gmail.com", password: "donkus", password_confirmation: "donkus")
        user2 = User.build(name: "Frss Mizzle", email: "THEFRIZZ@gmail.com", password: "blonkus", password_confirmation: "blonkus")

        expect(user2).not_to be_valid
        expect(user2.errors[:email]).to include('has already been taken')
      end
    end
  
    describe 'has_secure_password' do
      it { should have_secure_password }
    end
end