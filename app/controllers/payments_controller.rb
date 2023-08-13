class PaymentsController < ApplicationController
  # Create a payment and redirect user to payment link
  def create_payment
    amount = params[:amount]# Amount in paise (for example, 1000 paise = ₹10)
    currency = 'INR'
    description = 'Sample Payment Description'

    payment = Razorpay::Payment.create(amount: amount, currency: currency, description: description)

    redirect_to payment.notes['short_url'] # Redirect user to the payment link
  end

  # Handle Razorpay webhook for payment confirmation
  def webhook
    payload = request.body.read
    signature = request.headers['X-Razorpay-Signature']

    # Verify the signature using Razorpay's utility method
    if Razorpay::Utility.verify_webhook_signature(payload, signature, 'YOUR_WEBHOOK_SECRET')
      event = JSON.parse(payload)
      payment_id = event['payload']['payment']['entity']['id']
      payment = Razorpay::Payment.fetch(payment_id)

      if payment.status == 'captured'
        render json: {message: "Payment Successful"}
      else
        ender json: {message: "Payment status pending"}
      end
    else
      ender json: {message: "Payment Unsuccessful"}
    end

    head :ok
  end
end
