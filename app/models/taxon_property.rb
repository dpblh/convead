class TaxonProperty < ActiveRecord::Base
  self.table_name = "properties_taxons"
  
  belongs_to :taxon
  belongs_to :property
end