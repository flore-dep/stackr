class ScopesController < ApplicationController
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped

  def archive_licenses
    @licenses = Scope.where(team_id: current_user.team.id, plan_id: params[:plan_id]).first.licenses
    @licenses.update_all(end_date: Date.today)
    flash[:notice] = "Vos licenses ont été archivées"
    redirect_to team_path(current_user.team)
  end
end
