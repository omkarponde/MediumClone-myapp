class PaymentsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token


  require "razorpay"


  # Create a payment and redirect user to payment link
  def create_payment
    Razorpay.setup('rzp_test_tXaPmTEL1CJXM5', 'rp6rIQnDQTszivhDbZvttHnF')
    amount = params[:amount]
    currency = 'INR'
    description = 'Sample Payment Description'
    order = Razorpay::Order.create(amount: amount, currency: 'INR')

    render json: order
  end

  # Handle Razorpay webhook for payment confirmation
  def webhook
    Razorpay.setup('rzp_test_tXaPmTEL1CJXM5', 'rp6rIQnDQTszivhDbZvttHnF')
    payload = request.body.read
    signature = request.headers['X-Razorpay-Signature']

    # Verify the signature using Razorpay's utility method
    if Razorpay::Utility.verify_webhook_signature(payload, signature, 'omkar_ponde_webhook_key')

      event = JSON.parse(payload)
      payment_id = event['payload']['payment']['entity']['id']
      payment = Razorpay::Payment.fetch(payment_id)

      if payment.status == 'captured'
        render json: { message: 'Payment Successful' }
      else
        render json: { message: 'Payment status pending' }
      end
    else
      render json: { message: 'Payment Unsuccessful' }
    end

    head :ok
  end
end
