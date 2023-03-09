require 'uri'
require 'net/http'
class GolController < ApplicationController
  def index
  end

  def upload
    begin
      if params && params[:file]
        content = params[:file].read
        redirect_to action: "show", worldJson: CGI.escape(helpers.generateWorldJsonFromString(content))
      else
        raise "File not provided"
      end
    rescue => e
      flash[:alert] = e.message
      redirect_to gol_url
    end
  end

  def show
    if params[:worldJson]
      @worldJson = params[:worldJson]
    else
      flash[:alert] ="Bad request"
      redirect_to gol_url
    end
  end

  def next
    begin
      @worldJson = CGI.escape(helpers.calculate_next(params[:worldJson]))
      render turbo_stream:
        turbo_stream.replace(
          'worldJson',
          partial: 'world',
          locals: { worldJson: @worldJson } )
    rescue => e
      flash[:alert] = e.message
      redirect_to gol_url
    end
  end
end
