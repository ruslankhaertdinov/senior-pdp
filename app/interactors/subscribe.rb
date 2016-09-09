class Subscribe
  include Interactor::Organizer

  organize CreateCustomer, Charge, CreateSubscription
end
