class Assignment < ApplicationRecord
  belongs_to :account
  belongs_to :developer, optional: true

  scope :bid_accepted, -> { where(bid_accepted: true) }
  scope :pending, -> { where(bid_accepted: [false, nil]) }

  delegate :bid_content, to: :account, prefix: true

  def bid_placed
    self.update bid: true
  end

  def can_bid?
    !(bid? || bid_accepted?)
  end

  def passed? filters
    return true unless filters.present?
    filters.each do |filter|
      if filter.budget?
        if filter.equal_to?
          return false unless price == filter.value.to_f
        elsif filter.not_equal_to?
          return false if price == filter.value.to_f
        elsif filter.greater_or_equal_to?
          return false unless price >= filter.value.to_f
        elsif filter.less_or_equal_to?
          return false unless price <= filter.value.to_f
        end
      elsif filter.field?
        if filter.equal_to?
          return false unless field == filter.value
        elsif filter.not_equal_to?
          return false if field == filter.value
        end
      end
    end
    true
  end
end
