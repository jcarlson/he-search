class Search < ApplicationRecord
  validates :term, presence: true

  WITH_COUNTS = <<~SQL
    first_value(id)         OVER (PARTITION BY term ORDER BY created_at DESC) id,
    first_value(term)       OVER (PARTITION BY term ORDER BY created_at DESC) term,
    first_value(created_at) OVER (PARTITION BY term ORDER BY created_at DESC) created_at,
    first_value(updated_at) OVER (PARTITION BY term ORDER BY created_at DESC) updated_at,
    count(term)             OVER (PARTITION BY term) count
  SQL

  # Use a window function to partition rows by search term,
  # and augment each partition with `count` as a virtual attribute
  scope :trending, -> { distinct.select(WITH_COUNTS).order('count DESC, created_at DESC') }

  has_many :occurrences, class_name: 'Search', primary_key: :term, foreign_key: :term

  def count
    read_attribute(:count) || occurrences.count
  end

  def results
    @results ||= Brewery.search(term)
  end
end
