# Possibly already created by a migration.
unless Spree::Store.where(code: 'spree').exists?
  Spree::Store.new do |s|
    s.code              = 'Bazaar'
    s.name              = 'Bazaar Demo Site'
    s.url               = 'example.com'
    s.mail_from_address = 'bazaar@example.com'
  end.save!
end
