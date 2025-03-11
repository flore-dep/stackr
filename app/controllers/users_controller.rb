class UsersController < ApplicationController

  # WARNING - regles pundit à changer
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped

  def show
    @user_company = current_user.organization
    @licenses = current_user.licenses
   

    # @scopes = @licenses.map {|license| license.scope}
    raise
  end

end
