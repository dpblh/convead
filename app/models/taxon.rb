class Taxon < ActiveRecord::Base
  has_many :products
  has_many :taxon_properties
  has_many :properties, :through => :taxon_properties
end
