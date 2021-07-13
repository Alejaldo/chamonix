class EventPolicy < ApplicationPolicy
  def new?
    logged_in?
  end

  def create?
    logged_in?
  end

  def edit?
    owner?
  end

  def update?
    owner?
  end

  def destroy?
    owner?
  end

  def show?
    return true if record.pincode.blank?
    return true if owner?
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

  def logged_in?
    user.present?
  end
end
