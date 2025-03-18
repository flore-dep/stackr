class LicensesController < ApplicationController
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped
  def create
    @team = current_user.team
    @license = License.new(license_params)
    @plan = Plan.find(params[:plan_id])
    @license.plan = @plan
    @license.user = current_user
    @license.status = "Pending"

    @tool = @license.plan.tool

    if @license.save!
      redirect_to team_path(@team)
    else
      redirect_to tool_path(@tool)
    end
  end

  private

  def license_params
    params.require(:license).permit(:start_date, :end_date, :status, :access_type)
  end

  def accept
    @license = License.find(params[:id])
    @license.update(status: "Approved")
  end

  def reject
    @license = License.find(params[:id])
    @license.update(status: "Declined")
  end
end
