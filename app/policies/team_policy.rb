class TeamPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    user.organization == record.organization
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      user.organization.teams.all
    end
  end
end
