# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:session_token) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_length_of(:password).is_at_least(6) }
  # it { should validate_presence_of(:password) }

  describe "uniqueness" do
    before :each do
      create(:user)
    end
  
    it { should validate_uniqueness_of(:username) }
    it { should validate_uniqueness_of(:session_token) }
  end

  describe "::find_by_credentials" do
    before :each do
      build(:user)
    end

    it "should return specified user instance with correct creds" do
      expect(User.find_by_credentials(user.username, user.password)).to eq(user)
    end

    it "should return nil no user with these creds" do
      expect(User.find_by_credentials("hello", "goodbye")).to be(nil)
    end
  end
  
end
