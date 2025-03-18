class ScopesController < ApplicationController
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped

  def archive_licenses
    @licenses = Scope.where(team_id: current_user.team.id, plan_id: params[:plan_id]).first.licenses
    @licenses.update_all(end_date: Date.today)
    flash[:notice] = "Vos licenses ont été archivées"
    redirect_to team_path(current_user.team)
  end

  def create
    @team = current_user.team
    @scope = Scope.new(team_id: params[:team_id], plan_id: params[:scope][:plan_id])
    if @scope.save
      flash[:notice] = "#{@scope.tool.name} added to your stack"
    else
      flash[:notice] = "Error trying to add #{@scope.tool.name} to your stack"
    end
      redirect_to team_path(@team)
  end
end
