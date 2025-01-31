# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
     return unless user.manager?
     can [ :create, :update, :destroy ], Product
  end
end
