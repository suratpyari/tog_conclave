class AddSomeDataInConfigTable < ActiveRecord::Migration
  def self.up
    Tog::Config.create(:key => "plugins.tog_conclave.event.image.versions.big", :value => "145x100")
    Tog::Config.create(:key => "plugins.tog_conclave.event.image.versions.medium", :value => "100x75")
    Tog::Config.create(:key => "plugins.tog_conclave.event.image.versions.small", :value => "50x50")
    Tog::Config.create(:key => "plugins.tog_conclave.event.image.versions.tiny", :value => "25x25")
  end

  def self.down
    Tog::Config.find(:key => "plugins.tog_conclave.event.image.versions.big").delete
    Tog::Config.find(:key => "plugins.tog_conclave.event.image.versions.medium").delete
    Tog::Config.find(:key => "plugins.tog_conclave.event.image.versions.small").delete
    Tog::Config.find(:key => "plugins.tog_conclave.event.image.versions.tiny").delete
  end
end
