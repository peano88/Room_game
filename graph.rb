class PrimitiveGraph

	def initialize
		# Constructor
		@links = Hash.new "vec_type"
	end

	def set_new_link( first_node, second_node, vector_type)
		# First, get the specific vector links and then try
		# to add the provided link
		this_vector_type_links = resolve_vector_type( vector_type)
		resolve_link(first_node, second_node, this_vector_type_links)
	end

	def get_linked_node(start_node, vector_type)
		# First, obtain the link hash from the @links
		# and then look for the node linked to the provided one
		# using the provided vector type
		this_vector_type_links =  @links[vector_type.to_sym]
		if this_vector_type_links.nil?
			puts "Vector Type is not in the current schema"
			exit(0)
		end
		this_vector_type_links[start_node.to_sym]
	end	

	def links
		puts @links
	end

	private

	def resolve_vector_type(vector_type)
		# return the vector type hash, if does not exist create
		# a new one
		if @links.key?(vector_type.to_sym)
			@links[vector_type.to_sym]
		else
			@links[vector_type.to_sym] = Hash.new
		end
	end

	def resolve_link(first_node, second_node, link_hash)
		# check if the start node is already inserted; if not insert the new link
		if link_hash.key?(first_node.to_sym)
			puts "Provided first_node #{first_node} is already solved and cannot be changed"
			exit(0)
		else
			link_hash[first_node.to_sym] = second_node
		end
	end	
end
