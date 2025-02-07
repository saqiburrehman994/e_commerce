module SetCart
  extend ActiveSupport::Concern
  included do
    before_action :set_cart
  end

  private

  def set_cart
    @cart = current_user.cart || current_user.create_cart
  end
end
