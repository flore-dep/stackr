class OrganizationsController < ApplicationController
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped

  def index
    @organizations = policy_scope(Organization)
  end

  def show
    @organization = current_user.organization
    authorize @organization

    @tools = @organization.tools

    if params[:query].present?
      @tools = Tool.global_search("%#{params[:query]}%")
    end
  end
end
