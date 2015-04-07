namespace :db do
  desc 'Build a fresh demo data.'
  task demo: :environment do
    system("rm #{Rails.root}/db/#{Rails.env}.sqlite3")
    system("rake db:drop db:migrate db:seed")
    system("rake spree_sample:load --trace")
  end
end
