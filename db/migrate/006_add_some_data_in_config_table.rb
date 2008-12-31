class AddSomeDataInConfigTable < ActiveRecord::Migration
  def self.up
    Tog::Config.create(:key => "plugins.tog_conclave.event.image.versions.big", :value => "160x120")
    Tog::Config.create(:key => "plugins.tog_conclave.event.image.versions.medium", :value => "120x90")
    Tog::Config.create(:key => "plugins.tog_conclave.event.image.versions.small", :value => "60x45")
    Tog::Config.create(:key => "plugins.tog_conclave.event.image.versions.tiny", :value => "30x30")
  end

  def self.down
    Tog::Config.find(:key => "plugins.tog_conclave.event.image.versions.big").delete
    Tog::Config.find(:key => "plugins.tog_conclave.event.image.versions.medium").delete
    Tog::Config.find(:key => "plugins.tog_conclave.event.image.versions.small").delete
    Tog::Config.find(:key => "plugins.tog_conclave.event.image.versions.tiny").delete
  end
end
