class TeamsController < ApplicationController

  def index
    @teams = Teams.all
  end
end
