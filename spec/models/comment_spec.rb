require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should validate_presence_of :body }
  it { should ensure_length_of(:body).is_at_most(255) }
  it { should belong_to(:user) }
  it { should have_many(:votes).dependent(:destroy) }
end
