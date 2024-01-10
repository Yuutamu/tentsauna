class Customer < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # customize validation of Devise.gem
  with_options presence: true do
    validates :name
    validates :status
  end

  # Customer Status
  enum status: {
    normal: 0,    # 通常
    withdrawn: 1, # 退会済み
    banned: 2     # アカウント停止（運営判断による）
  }

  has_meny :cart_items, dependent: :destroy
end
