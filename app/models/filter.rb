class Filter < ApplicationRecord
  belongs_to :account

  validates :filter_type, :condition, :value, presence: true
  validate :allowed_condition

  enum filter_type: {
    budget: 0,
    field: 1,
  }

  enum condition: {
    equal_to: 0,
    not_equal_to: 1,
    greater_or_equal_to: 2,
    less_or_equal_to: 3,
  }

  def allowed_condition
    return unless field?
    return if equal_to? || not_equal_to?
    errors.add(:condition, "only equal_to and not_equal_to allowed for field filter")
  end
end
