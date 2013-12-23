class StaticPagesController < ApplicationController
  def home
  	@workshops = Workshop.all
  end
end
