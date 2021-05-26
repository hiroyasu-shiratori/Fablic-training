# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    title { 'タスク' }
    status { '未着手' }
  end
end
