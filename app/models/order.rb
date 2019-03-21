class Order < ApplicationRecord

  # 默认的 scope 放在最前（如果有的话）
  # 载入模组 Module
  include AASM

  # 接下来是常量初始化
  # 然后是 attr 相关
  # 第三方库设定
  # 关联
  belongs_to :user
  has_many :product_lists

  # 验证
  validates :billing_name, presence: true
  validates :billing_address, presence: true
  validates :shipping_name, presence: true
  validates :shipping_address, presence: true

  # callback
  before_create :generate_token

  # scope
  scope :recent,  -> { order("id DESC") }

  # 较长的第三方库设定，例如：aasm, amoeba 会带有 do..end proc 设定
  aasm do
    state :order_placed, initial: true
    state :paid
    state :shipping
    state :shipped
    state :order_cancelled
    state :good_returned


    event :make_payment, after_commit: :pay! do
      transitions from: :order_placed, to: :paid
    end

    event :ship do
      transitions from: :paid,         to: :shipping
    end

    event :deliver do
      transitions from: :shipping,     to: :shipped
    end

    event :return_good do
      transitions from: :shipped,      to: :good_returned
    end

    event :cancel_order do
      transitions from: [:order_placed, :paid], to: :order_cancelled
    end
  end

  def generate_token
    self.token = SecureRandom.uuid
  end

  def set_payment_with!(method)
    self.update_columns(payment_method: method )
  end

  def pay!
    self.update_columns(is_paid: true )
  end
end
