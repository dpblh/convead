class Property < ActiveRecord::Base
  has_many :product_properties, :dependent => :destroy
  has_many :products, :through => :product_properties
  has_many :possible_values
  has_many :taxon_properties
  has_many :taxons, :through => :taxon_properties
end