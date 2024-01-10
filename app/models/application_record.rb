class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  # メモ：latest スコープは全てのモデルに使用するので定義しておく
  scope :latest, -> { order(created_at: :desc) }
end
