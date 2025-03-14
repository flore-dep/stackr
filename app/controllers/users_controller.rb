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
    @user = User.find(params[:id])
    @licenses = @user.licenses
  end

  def create
    @user = User.new(user_params)
    @team = Team.find(params[:team_id])
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
