require 'rails_helper'

RSpec.describe User, type: :model do

  context 'Validations tests' do
    it 'is not valide without a first name' do
      user = build(:user, first_name: nil);
      expect(user).not_to be_valid
    end

    it 'is not valid without a last name' do
      user = build(:user, last_name: nil)
      expect(user).not_to be_valid
    end

    it 'is not valid without a username' do
      user = build(:user, username: nil)
      expect(user).not_to be_valid
    end

    it 'is not valid without a email' do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
    end
  end

  context 'Uniqeness tests' do
    it 'is not valid without a unique username' do
      user1 = create(:user)
      user2 = build(:user, username: user1.username)

      expect(user2).not_to be_valid
      expect(user2.errors[:username]).to include("has already been taken")
    end

    it 'is not valid without a unique email' do
      user1 = create(:user)
      user2 = build(:user, email: user1.email)

      expect(user2).not_to be_valid
      expect(user2.errors[:email]).to include("has already been taken")
    end
  end

  context 'destroy user and everything dependent on it' do
    let (:user) {create(:user)}
    let (:user_id) {user.id}

    before do
      user.destroy
    end

    # deletes user profile
    it 'deletes profile' do
      profile = Profile.find_by(user_id: user_id)
      expect(profile).to be_nil
    end

    # deletes user location
    it 'deletes location' do
      location = Location.find_by(locationable_id: user_id)
      expect(location).to be_nil
    end

    # deletes user posts
    it 'deletes posts' do
      posts = Post.where(user_id: user_id)
      expect(posts).to be_empty
    end

    # deltes user comments
    it 'deletes comments' do
      comments = Comment.where(user_id: user_id)
      expect(comments).to be_empty
    end
  end

#password

it 'is invalid when password is nil' do
  user = build(:user, password: nil)
end

#password_confirmation

it 'is invalid when password_confirmation is nil' do
  user = build(:user, password_confirmation: nil)
end

#hashes_the_password

it 'hashes the password' do
  user = create(:user)
  expect(user.password_digest).not_to eq 'password'
end


end