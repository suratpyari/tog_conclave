class AddSomeDataInConfigTable < ActiveRecord::Migration
  def self.up
    Tog::Config.create(:key => "plugins.tog_conclave.event.image.versions.big", :value => "120x160")
    Tog::Config.create(:key => "plugins.tog_conclave.event.image.versions.medium", :value => "90x120")
    Tog::Config.create(:key => "plugins.tog_conclave.event.image.versions.small", :value => "45x60")
    Tog::Config.create(:key => "plugins.tog_conclave.event.image.versions.tiny", :value => "30x30")
  end

  def self.down
    Tog::Config.find(:key => "plugins.tog_conclave.event.image.versions.big").delete
    Tog::Config.find(:key => "plugins.tog_conclave.event.image.versions.medium").delete
    Tog::Config.find(:key => "plugins.tog_conclave.event.image.versions.small").delete
    Tog::Config.find(:key => "plugins.tog_conclave.event.image.versions.tiny").delete
  end
end
