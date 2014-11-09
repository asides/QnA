require 'rails_helper'

RSpec.describe Question, type: :model do

  it { should validate_presence_of :title }
  it { should ensure_length_of(:title).is_at_most(300) }

  it { should validate_presence_of :body }
  it { should ensure_length_of(:body).is_at_most(10000) }

  it { should have_many(:answers).dependent(:destroy) }
  it { should have_many(:attachments).dependent(:destroy) }

  it { should belong_to :user }

  it { should accept_nested_attributes_for :attachments }

  it { should have_many :taggings }
  it { should have_many :tags }
end
