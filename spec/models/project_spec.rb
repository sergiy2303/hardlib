require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:user) { create(:user) }
  let(:user_2) {create(:user) }
  let(:project) { create(:project, user: user) }

  describe '#share_for' do
    context 'successfully create share for project' do
      it 'should create share for project' do
        expect(project.user).to eq(user)

        project.share_for(user_2)
        expect(user_2.foreign_shares.projects.first).to eq(project)
        expect(Share.all.count).to be(1)
      end
    end

    context 'error cases' do
      it 'should not create share if user nil' do
        expect(project.user).to eq(user)

        project.share_for(nil)
        expect(Share.all.count).to be(0)
      end
    end
  end
end
