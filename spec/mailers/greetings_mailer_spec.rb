require 'rails_helper'

RSpec.describe GreetingsMailer do
  describe '#send_regards' do
    user = create(:user)
    current_user = create(:user, email: 'logged_user@mail.com')
    let(:mail) { GreetingsMailer.send_regards(user, current_user) }

    it 'sends mail with regards' do
      expect(mail.body.encoded).to match('logged_user@mail.com sends his regards')
    end
  end
end