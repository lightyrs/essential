class MixesController < ApplicationController

  def index
    @mixes = Mix.all
  end
end
