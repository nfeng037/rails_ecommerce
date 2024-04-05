class ProvincesController < ApplicationController
  def tax_rates
    province = Province.find(params[:id])
    subtotal = current_cart.subtotal
    gst = subtotal * province.gst_rate
    pst = subtotal * province.pst_rate
    total = subtotal + gst + pst

    render json: { gst_rate: province.gst_rate, pst_rate: province.pst_rate, gst: gst, pst: pst, total: total }
  end
end
