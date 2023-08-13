class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  # config.stripe = {
  #   publishable_key: ENV['pk_test_51NeQtqSFOpUPo8lg3R0ImRRT96CvLPxt5MaJ8FifqB1R2xOjkNzojzG9SsfaP0FAM9eAsTVlese4TLdSHzVBZLIt00NtaprFe0'],
  #   secret_key: ENV['sk_test_51NeQtqSFOpUPo8lg04f1W7k2OYhSsx4j2MQWQpHTdcThS5vrF8RDgCGPObTi5fhd9gH2IcNggYfXpzKytnwfDlR100SGp7KJee']
  # }
  # Stripe.api_key = config.stripe[:secret_key]
end
