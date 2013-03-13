module Healthyr
   class Railtie < Rails::Railtie
     initializer 'healthyr.configure' do |app|
       Healthyr.boot(app)
     end
   end
end
