class Todo < ApplicationRecord
  belongs_to :user

  validates :title, presence: true

  scope :search_by_title, ->(search) { where("title ILIKE ?", "%#{sanitize_sql_like(search)}%") }
end
