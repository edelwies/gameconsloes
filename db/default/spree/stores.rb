# Possibly already created by a migration.
unless Spree::Store.where(code: 'bazaar').exists?
  Spree::Store.new do |s|
    s.code              = 'bazaar'
    s.name              = 'Bazaar Demo Site'
    s.url               = 'example.com'
    s.mail_from_address = 'bazaar@example.com'
    s.default_currency  = 'IRR'
  end.save!
end
