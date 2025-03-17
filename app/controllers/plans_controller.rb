class PlansController < ApplicationController
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped

  def create
    @plan = Plan.new(plan_params)
    @tool = Tool.find(params[:tool_id])
    @plan.organisation = current_user.organization.find(params[:organization_id])

    if @plan.save
      redirect_to team_path(@team)
    end
  end

  private

  def plan_params
    params.require(:plan).permit(:status, :formula)
  end
end
