class UsersController < ApplicationController

  # WARNING - regles pundit à changer
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped

  def index
    @users = current_user.organization.users
    @teams = current_user.organization.teams
    if params[:q].present?
      @users = Team.find(params[:q]).users
    end
  end

  def show
    @user = current_user.organization.users.find(params[:id])
    @licenses = @user.licenses
    @tools = current_user.team.tools.
      select("tools.*, min(licenses.start_date) as start_date, max(licenses.end_date) as end_date").
      joins(plans: :licenses).
      where(plans: { organization_id: current_user.organization.id }).
      group("tools.id")

    @plans_by_tool_id = Plan.where(tool_id: @tools.map(&:id), organization_id: current_user.organization.id).index_by(&:tool_id)
  end

  def create
    @user = User.new(user_params)
    @team = current_user.organization.teams.find(params[:team_id])
    @user.team = @team
    if @user.save!
      redirect_to team_path(@team)
    end
  end

  def destroy
    @user = User.find(params[:id])
    @team = @user.team
    @user.update!(end_date: user_params[:end_date])
    redirect_to team_path(@team)
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :role, :start_date, :end_date, :password)
  end
end

# hehehe trying to push 
