class TeamsController < ApplicationController

  def index
    @organization = current_user.organization
    @teams = Team.all
  end

  def show
    @team = Team.find(params[:id])
  end

  private

  def team_params
    params.require(:team).permit(:name)
  end
end
