# frozen_string_literal: true

require_relative 'node'

class Tree
  attr_accessor :root, :sorted

  def initialize(arr)
    @sorted = arr.sort.uniq
    @root = build_tree(@sorted, 0, @sorted.length)
  end

  def build_tree(arr, start_index, end_index)
    return nil if start_index > end_index

    middle = (start_index + end_index).div(2)
    return nil if arr[middle].nil?

    node = Node.new(arr[middle])
    node.left_child = build_tree(arr, start_index, middle - 1)
    node.right_child = build_tree(arr, middle + 1, end_index)
    node
  end

  def insert(value, node = @root)
    return Node.new(value) if node.nil?
    if value == node.value
      return node
    elsif value > node.value
      node.right_child = insert(value, node.right_child)
    else
      node.left_child = insert(value, node.left_child)
    end

    node
  end

  def level_order
    queue = []
    sorted_queue = []
    curr_node = @root
    queue.push(curr_node)
    until queue.empty?
      queue.push(curr_node.left_child) unless curr_node.left_child.nil?
      queue.push(curr_node.right_child) unless curr_node.right_child.nil?
      block_given? ? yield(queue.shift) : sorted_queue.push(queue.shift)
      curr_node = queue[0]
    end
    sorted_queue unless block_given?
  end

  def preorder(dfs_proc, node = @root)
    return if node.nil?

    dfs_proc.call(node)
    preorder(dfs_proc, node.left_child)
    preorder(dfs_proc, node.right_child)

  end

  def inorder(dfs_proc, node = @root)
    return if node.nil?

    inorder(dfs_proc, node.left_child)
    dfs_proc.call(node)
    inorder(dfs_proc, node.right_child)

  end

  def postorder(dfs_proc, node = @root)
    return if node.nil?

    postorder(dfs_proc, node.left_child)
    postorder(dfs_proc, node.right_child)
    dfs_proc.call(node)

  end

  def find(value, node = @root)
    return 'None' if node.nil?
    return node if node.value == value

    value > node.value ? find(value, node.right_child) : find(value, node.left_child)
  end

  def delete(value, node = @root)
    return node if node.nil?

    if value > node.value
      node.right_child = delete(value, node.right_child)
      return node
    elsif value < node.value
      node.left_child = delete(value, node.left_child)
      return node
    end
    shift_on_delete(node)
  end

  def shift_on_delete(node)
    return node.right_child if node.left_child.nil?

    return node.left_child if node.right_child.nil?

    succ_parent = node
    succ = node.right_child
    until succ.left_child.nil?
      succ_parent = succ
      succ = succ.left_child
    end
    if succ_parent != node
      succ_parent.left_child = succ.right_child
    else
      succ_parent.right_child = succ.right_child
    end
    node.value = succ.value
    node
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end
end

b_tree = Tree.new([5, 9, 13, 13, 11, 7, 2])
b_tree.pretty_print
# b_tree.level_order do |node|
#   puts "Node Value: #{node} Left Child: #{node.left_child} Right Child: #{node.right_child}"
# end
dfs_proc = proc do |node|
  puts "Node Value: #{node} Left Child: #{node.left_child} Right Child: #{node.right_child}"
end
b_tree.postorder(dfs_proc)
