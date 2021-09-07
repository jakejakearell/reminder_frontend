require 'rails_helper'

describe "Reminder Facade" do
  describe 'Happy Paths' do
    before :each do
      params = {:start_date=>"2021-09-07",
                :end_date=>"2021-09-09",
                :time=>"09:35",
                :message=>"asdfadsf dasdf asd sdfasd f sdfas sdf sd asdf asdf"
               }
      @user = User.create(
                          email: 'james_johhny@email.com',
                          password: 'james_johhny',
                          username: 'junior_jimmy'
                          )
      @reminder_facade_instance = ReminderFacade.new(params, @user)
    end

    describe 'instance methods' do
      describe '#valid?' do
        it 'returns true when all params are valid' do
          expect(@reminder_facade_instance.valid?).to eq(true)
        end
      end
    end
  end
end
