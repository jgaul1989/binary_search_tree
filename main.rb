# frozen_string_literal: true

require_relative 'node'
require_relative 'tree'

b_tree = Tree.new(Array.new(15) { rand(1..100) })
b_tree.pretty_print
puts "Is the tree balanced?: #{b_tree.balanced?}"
dfs_proc = proc do |node|
  puts "Node Value: #{node} Left Child: #{node.left_child} Right Child: #{node.right_child}"
end
puts 'Level Order: '
b_tree.level_order(&dfs_proc)
puts ''
puts 'Pre Order: '
b_tree.preorder(&dfs_proc)
puts ''
puts 'In Order: '
b_tree.inorder(&dfs_proc)
puts ''
puts 'Post Order: '
b_tree.postorder(&dfs_proc)
6.times { b_tree.insert(rand(1..100)) }
b_tree.rebalance unless b_tree.balanced?

b_tree.pretty_print
puts "Is the tree balanced?: #{b_tree.balanced?}"
dfs_proc = proc do |node|
  puts "Node Value: #{node} Left Child: #{node.left_child} Right Child: #{node.right_child}"
end
puts 'Level Order: '
b_tree.level_order(&dfs_proc)
puts ''
puts 'Pre Order: '
b_tree.preorder(&dfs_proc)
puts ''
puts 'In Order: '
b_tree.inorder(&dfs_proc)
puts ''
puts 'Post Order: '
b_tree.postorder(&dfs_proc)

