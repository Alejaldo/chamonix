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
    return true if record.pincode.blank?
    return true if user == record.user
    return true if record.pincode_valid?(cookies["events_#{record.id}_pincode"])

    false
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
