class TeamsController < ApplicationController
  def index
    @teams = policy_scope(Team)
    @organization = current_user.organization
  end

  def show
    @user = User.new
    @team = Team.find(params[:id])
    authorize @team
    @licenses = current_user.team.licenses
    @all_licenses = current_user.team.all_licenses
    @tools = current_user.team.tools.
      select("tools.*, min(licenses.start_date) as start_date, max(licenses.end_date) as end_date").
      joins(plans: :licenses).
      where(plans: { organization_id: current_user.organization.id }).
      group("tools.id")

    @plans_by_tool_id = Plan.where(tool_id: @tools.map(&:id), organization_id: current_user.organization.id).index_by(&:tool_id)
  end
end
