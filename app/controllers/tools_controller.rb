class ToolsController < ApplicationController
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped
  def index
    @tools = Tool.all
  end

  def show
    @tool = Tool.find(params[:id])
  end
end
