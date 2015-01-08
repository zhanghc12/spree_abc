class AssociateStoreWithSite < ActiveRecord::Migration
  def change
    add_column :spree_stores, :site_id, :integer, :default=>0
    add_column :spree_stores, :short_name, :string, :limit=>64
    Spree::Site.all.each{|site|
      if site.stores.blank?
        site.stores.create!( url: site.domain, name: site.name, short_name: site.short_name )
      end
    }
  end


end
