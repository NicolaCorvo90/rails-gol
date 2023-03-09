require_relative "cell"

class World

  attr_reader :world
  attr_reader :generation

  def initialize(generation, rows, cols)
    if generation < 0
      raise "Invalid generation"
    end

    if rows < 0
      raise "Invalid rows"
    end

    if cols < 0
      raise "Invalid cols"
    end

    @generation = generation

    @world = []
    rows.times do
    |row|
      @world.push([])
      cols.times do
      |col|
        @world[row].push(Cell.new(row, col, false))
      end
    end
  end

  def ==(other)
    result = self.generation == other.generation && self.world.length == other.world.length && self.world.at(0).length == other.world.at(0).length
    if result
      self.world.each_with_index do |line, rowIndex|
        line.each_with_index { |cell, colIndex|
          if cell != other.world.at(rowIndex).at(colIndex)
            result = false
            break
          end
        }
      end
    end
    result
  end

  def edit_cell_value(x, y, value)
    if x < 0 || x > @world.length
      raise "Invalid cell x"
    end
    if y < 0 || x > @world.at(0).length
      raise "Invalid cell x"
    end
    if value != false && value != true
      raise "Invalid cell value"
    end
    @world[x][y].status = value
  end

  def next
    @generation += 1

    toEdit = []

    @world.each_with_index do
    |row, rowIndex|
      row.each_with_index do
      |cell, colIndex|
        alive_neighbours = neighbours_alive(rowIndex, colIndex)
        if cell.status
          if alive_neighbours < 2 || alive_neighbours > 3
            toEdit << Cell.new(rowIndex, colIndex, false)
          end
        else
          if alive_neighbours == 3
            toEdit << Cell.new(rowIndex, colIndex, true)
          end
        end

      end
    end
    toEdit.each do |cell|
      self.edit_cell_value(cell.x, cell.y, cell.status)
    end
    self
  end

  def neighbours_alive(x, y)
    if x < 0
      raise "Invalid cell x"
    end
    if y < 0
      raise "Invalid cell x"
    end

    alive_neighbours = 0

    if x > 0 && y > 0 && @world[x-1][y-1].status == true
      alive_neighbours += 1
    end
    if x > 0 && @world[x-1][y].status == true
      alive_neighbours += 1
    end
    if x > 0 && y < @world.at(0).length-1 && @world[x-1][y+1].status == true
      alive_neighbours += 1
    end

    if y > 0 && @world[x][y-1].status == true
      alive_neighbours += 1
    end
    if y < @world.at(0).length-1 && @world[x][y+1].status == true
      alive_neighbours += 1
    end

    if x < @world.length-1 && y >= 0 && @world[x+1][y-1].status == true
      alive_neighbours += 1
    end
    if x < @world.length-1 && @world[x+1][y].status == true
      alive_neighbours += 1
    end
    if x < @world.length-1 && y < @world.at(0).length-1 && @world[x+1][y+1].status == true
      alive_neighbours += 1
    end

    alive_neighbours
  end

end