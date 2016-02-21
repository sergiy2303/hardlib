require 'rails_helper'

RSpec.describe ApplicationHelper do
  describe '#navbar_link_to' do
    it 'renders link in <li> tag' do
      expect(helper.navbar_link_to('Welcome', '/')).to eq('<li class=""><a href="/">Welcome</a></li>')
    end

    it 'adds active class to list element if current path starts with provided path' do
      expect(helper).to receive(:request).and_return(double(path: '/new_user_session'))
      expect(helper.navbar_link_to('Sign in', '/new_user_session')).to eq('<li class="active"><a href="/new_user_session">Sign in</a></li>')
    end
  end
end
