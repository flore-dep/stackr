class UsersController < ApplicationController

  # WARNING - regles pundit à changer
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped

  def show
    @user = current_user
    @licenses = current_user.licenses
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @team = Team.find(params[:team_id])
    @user.team = @team
    if @user.save!
      redirect_to team_path(@team)
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :role, :start_date, :end_date, :password)
  end
end
