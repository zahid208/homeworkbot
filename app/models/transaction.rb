class Transaction < ApplicationRecord
  belongs_to :account

  enum event: {
    withdrawal: 'Withdrawal',
    reverse_sponsored: 'Reverse Sponsored',
    sponsored_bid: 'Sponsored Bid',
    buyer_complaint: 'buyer_complaint',
    payment: 'payment',
    refund: 'refund_',
    adjustment: 'adjustment',
    other: 'other',
  }
end
