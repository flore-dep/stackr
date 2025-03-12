class UsersController < ApplicationController

  # WARNING - regles pundit à changer
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped

  def show
    @user = current_user
    @licenses = current_user.licenses
  end

end
