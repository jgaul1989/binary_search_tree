# frozen_string_literal: true

# represents a list node
class Node
  include Comparable
  attr_accessor :value, :left_child, :right_child

  def initialize(value)
    @value = value
    @left_child = nil
    @right_child = nil
  end

  def <=>(other)
    value <=> other.value
  end

  def to_s
    "(#{@value})"
  end
end
