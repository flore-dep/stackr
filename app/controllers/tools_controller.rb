class ToolsController < ApplicationController
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped

  def index
    @tools = policy_scope(Tool)
    @selected_categories = Array(params[:categories]).reject(&:blank?)

    @tools = @tools.global_search(params[:search]) if params[:search].present?
    @tools = @tools.where(category: @selected_categories) if @selected_categories.present?
  end

  def show
    @tool = Tool.find(params[:id])
    @plan = @tool.plans.find_by(id: params[:plan_id]) if params[:plan_id].present?
    @plan_organization = @tool.plans.where(organization: current_user.organization).first

    if @plan_organization.present?
      tool_user_list = @plan_organization.licenses.pluck(:user_id).uniq
      @users = User.where(id: tool_user_list)
    else
      @users = []
    end
    # Si aucun plan n'est trouvé -> création d'un nouveau plan
    if @plan.nil?
      @plan = Plan.new
    end
  end
end
