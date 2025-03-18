class UserPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.role == "Founder" || user.role == "Manager"
  end

  def destroy?
    user.role == "Founder" || user.role == "Manager"
  end


  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all
    end
  end
end
