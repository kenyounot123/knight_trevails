#Your task is to build a function knight_moves that shows the shortest possible way to get from one square to another
# by outputting all squares the knight will stop on along the way.
# knight_moves([0,0],[1,2]) == [[0,0],[1,2]]
# knight_moves([0,0],[3,3]) == [[0,0],[1,2],[3,3]]
# knight_moves([3,3],[0,0]) == [[3,3],[1,2],[0,0]]
class Gameboard
  def initialize(size)
    @size = size
  end
end
class Knight
  attr_accessor :moves, :location, :parent 
  def initialize(location, parent=nil)
    @location = location
    @moves = [
      [1,2], [-1,2], [-1,-2], [1,-2], [2,1], [-2,1], [-2,-1], [2,-1]
    ]
    @parent = parent
  end
  def all_possible_moves(start = @location, result=[]) #this method shows all possible moves given a position (children nodes of a tree)
    @moves.each do |move|
      x = start[0] + move[0]
      y = start[1] + move[1]
      result << [x,y] if x.between?(0,7) && y.between?(0,7) #between? interval changes depending on board size
    end
    result
  end
  def knight_moves(start_position, end_position)
    #loop until knight's position is equal to end position
    knights_queue = []
    knights_queue.push(Knight.new(start_position))
    until knights_queue.empty? 
      current_knight = knights_queue.shift
      current_position = current_knight.location
      return path(current_knight) if current_position == end_position
      next_move = all_possible_moves(current_position) 
      next_move.each do |move|
        knights_queue << Knight.new(move, current_knight) #assigns a parent to the child
      end
    end
  end

  def path(knight) #returns the path the knight took ( its previous moves )
    path = []
    current_knight = knight
    #if we are given path(knight) where knight is already the root then return []
    return path if current_knight.parent.nil?
    until current_knight.nil?
      path.unshift(current_knight.location)
      current_knight = current_knight.parent
    end
    puts "You made it in #{path.length - 1} moves!  Here's your path: "
    p path
  end
end



#breadth first search to find the shortest route (involves queue)
#we start creating our tree by creating a queue that starts with our first instance of knight class(no parents)
#we dequeue the first knight class 
#loop until queue is empty
#       enqueue a new instance of knight class with the preceding knight as its parent if the knight's location does not match the end location
#       the new knights will take in the position of a possible move as its parameters
#       return an array that shows the path of that knight took if the knight's current position matches the ending position
my_piece = Knight.new([3,3])

my_piece.knight_moves([3,3],[4,3])


