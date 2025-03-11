class TeamsController < ApplicationController
  def index
    @teams = policy_scope(Team)
  end

  def show
    @team = Team.find(params[:id])
    authorize @team
  end
end
