require "test_helper"

class SearchTest < ActiveSupport::TestCase
  context 'validations' do
    should validate_presence_of(:radius)
    should validate_numericality_of(:radius)

    should validate_presence_of(:latitude)
    should validate_numericality_of(:latitude)
    should validate_numericality_of(:latitude).is_less_than_or_equal_to(90)
    should validate_numericality_of(:latitude).is_greater_than_or_equal_to(-90)

    should validate_presence_of(:longitude)
    should validate_numericality_of(:longitude)
    should validate_numericality_of(:longitude).is_less_than_or_equal_to(90)
    should validate_numericality_of(:longitude).is_greater_than_or_equal_to(-90)
  end
end