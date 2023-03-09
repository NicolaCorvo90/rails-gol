module GolFileHelper
  def generateWorldJsonFromString(string)
    lines = self.extractLinesFromString(string)

    generation = self.extractGenerationFromString(lines[0])
    rows = self.extractRowsColsFromString(lines[1])
    cols = self.extractRowsColsFromString(lines[1], true)
    world = self.createWorld(generation, rows, cols, lines.drop(2))
    world.to_json
  end

  def extractLinesFromString(string)
    lines = string.split("\n")
    if lines.empty?
      raise "Error on extracting lines from string"
    end
    if lines.length == 1
      raise "The file provided doesn't contain a matrix"
    end
    lines
  end

  def extractGenerationFromString(string)
    if string.include?("Generation") && string[11].to_i >= 0
      generation = string[11].to_i
    else
      raise "Invalid string"
    end
    generation
  end

  def extractRowsColsFromString(string, cols = false)
    if string.length == 4 && string[cols ? 2 : 0].to_i > 0
      result = string[cols ? 2 : 0].to_i
    else
      raise "Invalid string"
    end
    result
  end

  def createWorld(generation, rows, cols, lines)
    world = World.new(generation, rows, cols)
    lines.each_with_index do
    |line, rowIndex|
      line.strip.split('').each_with_index do
      |cell, colIndex|
        case cell
        when "."
          cellValue = false
        when "*"
          cellValue = true
        else
          raise "Invalid cell value"
        end

        world.edit_cell_value(rowIndex, colIndex, cellValue)
      end
    end
    world
  end
end