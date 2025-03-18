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
    @plan = Plan.new
    @plan_organization = @tool.plans.where(organization: current_user.organization).first
  end
end
