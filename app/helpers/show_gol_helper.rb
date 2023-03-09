module ShowGolHelper
  def getGenerationFromJSON(jsonEncoded)
    begin
      json = unescapeParseJSON(jsonEncoded)
      json['generation']
    rescue => e
      flash[:alert] = e.message
      redirect_to gol_url
    end
  end

  def worldJsonFromJSON(jsonEncoded)
    begin
      json = unescapeParseJSON(jsonEncoded)
      json['world']
    rescue => e
      flash[:alert] = e.message
      redirect_to gol_url
    end
  end
end