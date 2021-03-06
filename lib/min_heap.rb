class HeapNode
  attr_reader :key, :value

  def initialize(key, value)
    @key = key
    @value = value
  end
end

class MinHeap
  attr_reader :store
  def initialize
    @store = []
  end

  # This method adds a HeapNode instance to the heap
  # Time Complexity: O(logn) At worse, the heap_up function will have to iterate logn times to add a heapnode from the leaf to the root of the heap
  # Space Complexity: O(logn) the heap_up function doesn't store additional variables, but does make logn recursive calls to the memory stack in worst case
  def add(key, value = key)
    @store << HeapNode.new(key, value)
    
    heap_up(@store.length - 1)
  end

  # This method removes and returns an element from the heap
  #   maintaining the heap structure
  # Time Complexity: O(logn) At worse, the heap_down function will have to iterate logn times to remove a heapnode 
  # Space Complexity: O(logn) the remove function doesn't store additional variables, but does make logn recursive calls to the memory stack in worst case
  def remove()

    temp_root = @store[0]
    swap(0, @store.length - 1)
    @store.delete_at(@store.length - 1)

    heap_down(0) unless @store.empty?

    return temp_root.value
  end


  # Used for Testing
  def to_s
    return "[]" if @store.empty?

    output = "["
    (@store.length - 1).times do |index|
      output += @store[index].value + ", "
    end

    output += @store.last.value + "]"
      
    return output
  end

  # This method returns true if the heap is empty
  # Time complexity: O(n) checks the length of @store, which varies linearly with the length of the heap
  # Space complexity: O(1) variables stay constant regardless of length of heap
  def empty?
    return @store.empty?
  end

  private

  # This helper method takes an index and
  #  moves it up the heap, if it is less than it's parent node.
  #  It could be **very** helpful for the add method.
  # Time Complexity: O(logn) At worse, the heap_up function will have to iterate logn times to add a heapnode from the leaf to the root of the heap
  # Space Complexity: O(logn) the heap_up function doesn't store additional variables, but does make logn recursive calls to the memory stack in worst case
  def heap_up(current_index)
    parent_index = (current_index - 1)/2

    if !exists?(parent_index) || @store[current_index].key > @store[parent_index].key
      return
    else
      swap(current_index, parent_index)
      heap_up(parent_index)
    end
  end

  # This helper method takes an index and 
  #  moves it down the heap if it's larger
  #  than it's children nodes.
  def heap_down(current_index)
    l_child_index = (current_index * 2) + 1
    r_child_index = (current_index * 2) + 2
    right_exists = exists?(r_child_index)
    left_exists = exists?(l_child_index)

    # if both exist
    if left_exists && right_exists 
      # if current is less than both
      if (@store[current_index].key < @store[l_child_index].key && @store[current_index].key < @store[r_child_index].key)
        return 
      # if left is less than right
      elsif @store[l_child_index].key < @store[r_child_index].key
        swap(current_index, l_child_index)
        heap_down(l_child_index)
      # if right is less than left
      elsif @store[r_child_index].key < @store[l_child_index].key
        swap(current_index, r_child_index)
        heap_down(r_child_index)
      end
    # if only left exists
    elsif left_exists 
      if @store[l_child_index].key < @store[current_index].key
        swap(current_index, l_child_index)
        heap_down(l_child_index)
      end
    # if only right exists
    elsif right_exists
      if @store[r_child_index].key < @store[current_index].key
        swap(current_index, r_child_index)
        heap_down(r_child_index)
      end
    end
    
    return
  end

  def exists?(index)
    return index > -1 && index < @store.length
  end

  # If you want a swap method... you're welcome
  def swap(index_1, index_2)
    temp = @store[index_1]
    @store[index_1] = @store[index_2]
    @store[index_2] = temp
  end
end