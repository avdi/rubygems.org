desc "Populate the db with fake data"
task :populate, [:n, :reuse_owners] => :environment do |_t, args|
  require "factory_girl"
  require "faker"
  require "spicy-proton"
  require "./test/factories"

  args.with_defaults(n: 1, reuse_owners: "no")
  n = args.n.to_i
  reuse_owners = args.reuse_owners == "yes"

  n.times do |i|
    catch do |skip|
      iteration = "%6d/%-6d" % [i + 1, n]
      gem = generate_fake_gem(reuse_owners: reuse_owners) do |error|
        puts "SKIP (#{error})"
        throw skip
      end
      puts "CREATE GEM #{iteration} #{gem.name} by #{gem.owners.map(&:handle).join(', ')}"
    end
  end
end

def generate_fake_gem(reuse_owners: false)
  ActiveRecord::Base.transaction do
    FactoryGirl.create(:rubygem,
      name: Spicy::Proton.format('%a-%a-%n'),
      owners: reuse_owners ? find_some_randome_fake_gem_owners : generate_some_fake_gem_owners) do |rubygem|
      rand(1..100).times do
        FactoryGirl.create(:version,
          rubygem: rubygem,
          authors: [Faker::Name.name],
          description: Faker::Lovecraft.sentence)
      end
    end
  end
rescue ActiveRecord::RecordInvalid => e
  yield e
end

def generate_some_fake_gem_owners
  owners = []
  rand(1..3).times do
    owners << FactoryGirl.create(:user,
      email: Faker::Internet.unique.email,
      handle: Faker::Internet.unique.username.tr_s("^a-zA-Z0-0_-", "_"))
  end
  owners
end

def find_some_randome_fake_gem_owners
  User.limit(rand(1..3)).order("RANDOM()").select(:id)
end
