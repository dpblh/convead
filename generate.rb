require './config/environment.rb'
prop = Property.all
print 'start'

def generate
begin
(1..90000).to_a.each {|i| prop1 = (1..10).map{|e| ProductProperty.create(property: prop.sample, num_value: rand.rand(6..6000))}; Product.create(name: :some, taxon: taxon, product_properties: prop1)}
rescue Exception => ex
	print ex
end
end

generate()


	