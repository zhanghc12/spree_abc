require 'spec_helper'
describe Spree::Taxon do

  
  it "should copy" do
    Spree::Site.current = Spree::Site.find 2
    
    taxon = Spree::Taxon.roots.first
    Spree::Site.current = Spree::Site.find 1
    new_taxon = Spree::Taxon.find_or_copy taxon
    new_taxon.reload
    new_taxon.taxonomy.should be_present?
    new_taxon.children.should eq taxon.children    
  end
  
  #TODO
  # test add_section_piece, section_param should be added
end
