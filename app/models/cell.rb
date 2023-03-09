class Cell

  attr_reader :x
  attr_reader :y
  attr_accessor :status

  def initialize(x, y, status)
    if x < 0
      raise "Invalid x"
    end
    if y < 0
      raise "Invalid y"
    end
    if status != false && status != true
      raise "Invalid status"
    end

    @x = x
    @y = y
    @status = status
  end

  def ==(other)
    self.x  == other.x && self.y == other.y && self.status == other.status
  end

end