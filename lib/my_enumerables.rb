# frozen_string_literal: true

module Enumerable
  def my_all?
    my_each do |item|
      return false unless yield(item)
    end
    true
  end

  def my_none?
    my_each do |item|
      return false if yield(item)
    end
    true
  end

  def my_any?
    my_each do |item|
      return true if yield(item)
    end
    false
  end

  def my_count
    return size unless block_given?

    count = 0
    my_each do |item|
      count += 1 if yield(item)
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

  def my_select
    result = []
    my_each do |item|
      result << item if yield(item)
    end
    result
  end

  def my_map
    result = []
    my_each do |item|
      result << yield(item)
    end
    result
  end

  def my_inject(accumulator)
    result = accumulator || first
    my_each do |item|
      result = yield(result, item)
    end
    result
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
