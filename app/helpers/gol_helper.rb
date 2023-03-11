module GolHelper
  def unescapeParseJSON(jsonEncoded)
    begin
      JSON.parse(CGI.unescape(jsonEncoded))
    rescue => e
      flash[:alert] = e.message
      redirect_to gol_url
    end
  end

  def worldJsonToWorld(json)
    if !json.key?('generation')
      raise "Invalid JSON : It doesn't have generation key"
    end
    if !json.key?('world')
      raise "Invalid JSON : It doesn't have world key"
    end
    generation = json['generation']
    rows = json["world"].length
    cols = json["world"][0].length
    world = World.new(generation, rows, cols)
    json["world"].each_with_index do
    |cols, rowIndex|
      cols.each_with_index do
      |cell, colIndex|
        cellValue = cell["status"]
        world.edit_cell_value(rowIndex, colIndex, cellValue)
      end
    end
    world
  end

  def calculate_next(worldJson)
    worldJson = worldJsonToWorld(unescapeParseJSON(worldJson)).next.to_json
    worldJson
  end
end