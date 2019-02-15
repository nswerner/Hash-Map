require 'byebug'

class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable

  attr_accessor :head, :tail

  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    return nil if empty?
    @head.next
  end
  
  def last
    return nil if empty?
    @tail.prev
  end

  def empty?
    head.next == tail
  end

  def get(key)
    each do |link|
      return link.val if link.key == key
    end

    nil
  end

  def include?(key)
    each do |link|
      return true if link.key == key
    end

    false
  end

  def append(key, val)
    new_node = Node.new(key, val)
    new_node.next = tail
    new_node.prev = tail.prev

    tail.prev = new_node
    new_node.prev.next = new_node
  end

  def update(key, val)
    each do |link|
      link.val = val if link.key == key
    end
  end

  def remove(key)
    return nil unless include?(key)
    removed_node = nil
    each do |link|
      removed_node = link if link.key == key
    end

    tail_side = removed_node.next
    head_side = removed_node.prev
  
    tail_side.prev = head_side
    head_side.next = tail_side

    removed_node
  end

  def each(&prc)

    next_link = first
    until next_link == tail || next_link.nil?
      prc.call(next_link)
      next_link = next_link.next
    end

    self
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
