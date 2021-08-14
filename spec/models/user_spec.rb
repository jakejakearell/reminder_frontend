require 'rails_helper'

describe User, type: :model  do
  describe "validations" do
    it {should validate_presence_of(:username)}
    it {should validate_uniqueness_of(:username)}
    it {should validate_presence_of(:email)}
    it {should validate_uniqueness_of(:email)}
    it {should validate_presence_of(:password)}
  end

  describe "email format" do
     it "create a user with a valid email format" do
       user = User.create!(
                          username: "bigpoppa",
                          email: 'jakye@email.com',
                          password: 'password'
                          )

       expect(user.email).to eq('jakye@email.com')
     end

     it "should not create a user with a invalid email format" do
       user = User.new(
                          username: "bigpoppa",
                          email: 'jaky',
                          password: 'password'
                          )

       expect(user.save).to eq(false)
     end
   end
end
