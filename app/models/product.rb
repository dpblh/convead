class Product < ActiveRecord::Base
  has_many :product_properties, :include => {:property => [:possible_values]}
  has_many :properties, :through => :product_properties
  belongs_to :taxon
  # monster sql
  def self.similar (product)
	product_ids = Product.connection.select_all(
		"""
		select posts.id, sum(posts.pos_num_value) as \"sum\" from

			(select \"search\".id, (
				(select coalesce(position(cast(\"search\".pp0_num_value as text) in cast(\"search\".num_value as text)), 0)) + 
				(select coalesce(position(cast(\"search\".pp0_bool_value as text) in cast(\"search\".bool_value as text)), 0)) + 
				(select coalesce(position(cast(\"search\".pp0_str_value as text) in cast(\"search\".str_value as text)), 0))
				) as pos_num_value
			
			from 
			(select p.id, pp.num_value, pp.bool_value, pp.str_value, pp0.num_value as pp0_num_value, pp0.bool_value as pp0_bool_value, pp0.str_value as pp0_str_value 
				from products p  left join taxons taxon on taxon.id = p.taxon_id left join properties_taxons pt on pt.taxon_id = taxon.id left join properties tpp on tpp.id = pt.property_id left join product_properties pp on p.id = pp.product_id left join properties ps on pp.property_id = ps.id,
				products p0 left join product_properties pp0 on p0.id = pp0.product_id left join properties ps0 on pp0.property_id = ps0.id
					where p0.id = #{product.id} and tpp.id = ps0.id and ps0.id = ps.id and (pp.num_value = pp0.num_value or pp.bool_value = pp0.bool_value or pp.str_value = pp0.str_value)) as \"search\"
						) as posts group by id order by \"sum\" DESC limit 6;
				"""
	) 
	ids = [] 
	product_ids.each {|e| ids << e['id']}
  	Product.find ids
  end
 
  @index = 0
end