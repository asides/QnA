# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
Question.destroy_all
Comment.destroy_all
Answer.destroy_all

users = FactoryGirl.create_list(:user, 3)
users[0].update(admin: true)


3.times { |i| Question.create!(title: LoremIpsum.short, body: LoremIpsum.medium("<br />"), user: users[i]) }


