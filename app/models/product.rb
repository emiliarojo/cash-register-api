class Product < ApplicationRecord
  validates :code, presence: true
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  validate :validate_discount_configuration

  private

  def validate_discount_configuration
    if bulk_eligible?
      errors.add(:base, 'Specify either a new price or a discount factor for bulk discounts, not both.') if new_price.present? && discount_factor.present?
      errors.add(:base, 'Specify at least one discount method for bulk discounts.') if new_price.blank? && discount_factor.blank?
    end
  end
end
