# frozen_string_literal: true

module Enumerable
  def my_all?
    my_each do |element|
      return false unless yield(element)
    end
    true
  end

  def my_any?
    my_each do |element|
      return true if yield(element)
    end
    false
  end

  def my_count
    return size unless block_given?

    count = 0
    my_each do |element|
      count += 1 if yield(element)
    end

    count
  end

  def my_each_with_index
    index = 0
    my_each do |item|
      yield(item, index)
      index += 1
    end
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
