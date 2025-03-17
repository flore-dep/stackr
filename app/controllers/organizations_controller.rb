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
    @teams = @organization.teams

    @selected_teams = Array(params[:teams]).reject(&:blank?)

    @teams = @teams.team_search(params[:search]) if params[:search].present?
    @teams = @teams.where(name: @selected_teams) if @selected_teams.present?
  end
end
