# frozen_string_literal: true

class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
  validates :description, length: { maximum: 1000 }
  validates :status, presence: true, length: { maximum: 10 }, inclusion: { in: %w[未着手 進行中 完了] }
  validates :priority, length: { maximum: 10 }, inclusion: { in: ['高', '中', '低', '', nil] }
end
