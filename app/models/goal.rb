class Goal < ActiveRecord::Base
  validates :title, presence: true
  validates :user_id, presence: true
  validates :privacy, inclusion: %w(private public)

  belongs_to :user
end
