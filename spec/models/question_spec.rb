require 'rails_helper'

RSpec.describe Question, :type => :model do

  it { should validate_presence_of :title }
  it { should ensure_length_of(:title).is_at_most(255) }

  it { should validate_presence_of :body }
  it { should ensure_length_of(:body).is_at_most(1000) }

  it { should have_many(:answers).dependent(:destroy) }
  it { should have_many(:attachments).dependent(:destroy) }
  
  it { should belong_to :user }
  it { should validate_presence_of :user }
end
