class CommentPolicy < ApplicationPolicy
  def show?
    return true
  end

  def create?
    return false
  end

  def update?
    return true if user.admin? || user.manager?
  end

  def destroy?
    return true if user.admin? || user.manager?
    return true if record.id == user.id
  end
end
