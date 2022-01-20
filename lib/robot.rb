class Robot
  @@DIRECTIONS = [:north, :east, :south, :west].freeze
  attr_reader :direction, :x, :y, :boundary_x, :boundary_y  
  
  def initialize(direction: :north, x: nil, y: nil, boundary_x: 5, boundary_y: 5)
    @boundary_x = boundary_x
    @boundary_y = boundary_y
    self.direction = direction
    self.x = x
    self.y = y        
  end

  def place(x, y, direction)
    self.x = x
    self.y = y
    self.direction = direction
  end

  def placed?
    !(@x.nil? || @y.nil?)
  end

  def unplaced!
    @x = nil
    @y = nil
    @direction = nil
  end
  
  def left
    @direction = (@direction - 1)  % @@DIRECTIONS.size
    direction
  end

  def right
    @direction = (@direction + 1)  % @@DIRECTIONS.size
    direction
  end

  def direction
    @@DIRECTIONS[@direction]
  end
  
  # It moves the robot to the next position and returns it
  def move
    return position unless placed?
    @x, @y  = next_position    
    position
  end 

  def report
    puts to_s
  end

  def position
    [@x, @y]
  end
  
  private

  def direction=(direction)
    @direction = @@DIRECTIONS.index(direction) || (raise ArgumentError.new("Invalid direction"))
  end

  def y=(value)
    raise RangeError.new if (!value.nil? && (value < 0 || value >= boundary_y))
    @y = value
  end

  def x=(value)
    raise RangeError.new if (!value.nil? && (value < 0 || value >= boundary_x))
    @x = value
  end  

  # Returns the next position where it would move
  # if the next position is out of the boundaries or invalid
  # it returns the current position 
  def next_position    
    next_p = case direction
      when :north
        [@x, @y + 1]
      when :south
        [@x, @y - 1]
      when :west
        [@x - 1, @y]
      when :east
        [@x + 1, @y]
      else
        [x, y]
    end
    next_x, next_y = next_p
    return [x, y] if next_p.include?(-1) || next_x >= boundary_x || next_y >= boundary_y
    next_p
  end
  
  def to_s
    "#{x},#{y},#{direction.to_s.upcase}"
  end
end
