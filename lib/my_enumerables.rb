# frozen_string_literal: true

module Enumerable
  def my_all?(&block)
    my_each do |element|
      return false unless block.call(element)
    end
    true
  end

  def my_any?(&block)
    my_each do |element|
      return true if block.call(element)
    end
    false
  end

  def my_count(&block)
    return size unless block_given?

    count = 0
    my_each do |element|
      count += 1 if block.call(element)
    end

    count
  end
end

class Array
  include Enumerable

  def my_each
    return to_enum(:my_each) unless block_given?

    i = 0
    while i < size
      yield(self[i])
      i += 1
    end
    self
  end
end
