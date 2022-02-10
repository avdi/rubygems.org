desc "Populate the db with fake data"
task :populate => :environment do 
  require "factory_girl"
  require "faker"
  require "spicy-proton"
  require "./test/factories"

  10.times do |i|
    owners = rand(5).times.map {
      FactoryGirl.create(:user, 
        email: Faker::Internet.email, 
        handle: p(Faker::Internet.username.tr_s("^a-zA-Z0-0_-", "_")))
    }
    FactoryGirl.create(:rubygem, name: Spicy::Proton.pair, owners: owners) do |rubygem|
      rand(100).times do
        FactoryGirl.create(:version, rubygem: rubygem, authors: [ Faker::Name.name ])
      end
    end
  end
end