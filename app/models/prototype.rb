class Prototype < ApplicationRecord
    belongs_to :user
    has_one_attached :image
    has_many :comments, dependent: :destroy
    with_options presence: true do
        validates :catch_copy
        validates :image
        validates :title
        validates :concept
      end
end
