class EventPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def edit?
    owner?
  end

  def update?
    user_is_owner?(record) || user.admin?
  end

  def destroy?
    owner?
  end

  def show?
    owner? || record.pincode.blank? || record.true_pincode?(cookies["event_#{record.id}_pincode"])
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  private

  def owner?
    user == record.user
  end
end
