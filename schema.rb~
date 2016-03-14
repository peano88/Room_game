module Schema

require_relative 'graph'

#schema =  PrimitiveGraph.new

def Schema.setup_schema(schema)
schema.set_new_link('a','b', 'first')
schema.set_new_link('b','a', 'first')
schema.set_new_link('a','f', 'second')
schema.set_new_link('f','a', 'second')
schema.set_new_link('b','g', 'second')
schema.set_new_link('g','b', 'second')
schema.set_new_link('b','c', 'third')
schema.set_new_link('c','b', 'third')
schema.set_new_link('c','d', 'first')
schema.set_new_link('d','c', 'first')
schema.set_new_link('d','g', 'third')
schema.set_new_link('g','d', 'third')
schema.set_new_link('d','e', 'second')
schema.set_new_link('e','d', 'second')
schema.set_new_link('e','g', 'first')
schema.set_new_link('g','e', 'first')
schema.set_new_link('e','f', 'third')
schema.set_new_link('f','e', 'third')
schema.set_new_link('a','y', 'third')
schema.set_new_link('c','y', 'second')
schema.set_new_link('f','y', 'first')
end

# Unit test
# Set test flag to false in order to inactivate the unit test
def unit_test
test_flag = false

schema =  PrimitiveGraph.new
Schema.setup_schema(schema)

failed_test = " Failed test on %s direction %d"	

if test_flag == true

	puts schema.links

	if schema.get_linked_node('a', 'first') != 'b'
		puts failed_test % 'a', 'first'
	end

	if schema.get_linked_node('d','second') != 'e'
		puts failed_test % 'd', 'second'
	end

	if schema.get_linked_node('e', 'third') != 'f'
		puts failed_test % 'e', 'third'
	end

end

end

end

