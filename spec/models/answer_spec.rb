require 'rails_helper'

RSpec.describe Answer, :type => :model do
  it { should validate_presence_of :body }
  it { should ensure_length_of(:body).is_at_most(1000) }

  it { should belong_to(:question) }
  it { should have_many :attachments }
  it { should validate_presence_of :question }

  it { should accept_nested_attributes_for :attachments }
end
