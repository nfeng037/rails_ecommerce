class ApplicationController < ActionController::Base
  include Devise::Controllers::Helpers

  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :set_render_cart
  before_action :initialize_cart

  def set_render_cart
    @render_cart = true
  end

  def initialize_cart
    @cart ||= Cart.find_by(id: session[:cart_id])

    if @cart.nil?
      @cart = Cart.create
      session[:cart_id] = @cart.id
    end
  end

  helper_method :current_cart

  def current_cart
    if session[:cart_id]
      cart = Cart.find_by(id: session[:cart_id])
      if cart.present?
        cart
      else
        cart = Cart.create
        session[:cart_id] = cart.id
        cart
      end
    else
      cart = Cart.create
      session[:cart_id] = cart.id
      cart
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :address, :city, :postal_code, :province_id, :phone_number])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :address, :city, :postal_code, :province_id, :phone_number])
  end
end
