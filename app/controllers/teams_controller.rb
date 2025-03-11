class TeamsController < ApplicationController

  def index
    @organization = current_user.organization
    @teams = Team.all
  end

end
