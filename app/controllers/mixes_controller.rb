class MixesController < ApplicationController

  def index
    @mixes = Mix.where.not(air_date: nil).order('air_date DESC').page(params[:page])
  end
end
