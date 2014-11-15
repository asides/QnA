require 'rails_helper'

RSpec.describe Vote, :type => :model do

  it { should validate_presence_of :score }

  it { should have_many :users }
  it { should have_many :votable }
end
