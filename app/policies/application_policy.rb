class ApplicationPolicy
  attr_reader :pincode_cookies, :record, :cookies, :user

  delegate :cookies, to: :pincode_cookies
  delegate :user, to: :pincode_cookies

  def initialize(pincode_cookies, record)
    @pincode_cookies = pincode_cookies
    @record = record
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end
  end
end
