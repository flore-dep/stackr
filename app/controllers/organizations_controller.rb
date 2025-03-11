class OrganizationsController < ApplicationController

  def index
    @organizations = policy_scope(Organization)
  end

  def show
    @organization = Organization.find(params[:id])
    authorize @organization
  end
end
