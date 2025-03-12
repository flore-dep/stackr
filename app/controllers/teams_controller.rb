class TeamsController < ApplicationController
  def index
    @teams = policy_scope(Team)
    @organization = current_user.organization
  end

  def show
    @team = Team.find(params[:id])
    authorize @team
    @licenses = current_user.team.licenses
  end
end
