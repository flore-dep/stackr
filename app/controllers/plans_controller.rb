class PlansController < ApplicationController
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped

  def create
    @plan = Plan.new(plan_params)
    @tool = Tool.find(params[:tool_id])
    @plan.tool = @tool
    @plan.organization = current_user.organization

    formula_key = params[:plan][:formula]
    formulas = JSON.parse(@tool.formulas)
    @plan.formula = { formula_key => formulas[formula_key] }.to_a.flatten
    @plan.status = "Pending"
    # raise

    if @plan.save!
      redirect_to tool_path(@tool)
    else
      redirect_to tools_path
    end
  end

  private

  def plan_params
    params.require(:plan).permit(:status, :formula)
  end
end
