class Product < ApplicationRecord
  with_options presence: true do
    validates :name
    validates :description
    validates :price
    validates :stock
    validates :image
  end
  has_one_attached :image # ActiveStrage にて作成した画像投稿機能。カラム名を"image"と命名しProductテーブルに付け足す

  # 商品ソート用のスコープ
  scope :price_high_to_low, -> { order(price: :desc) }
  scope :price_low_to_high, -> { order(price: :asc) }

  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
end
