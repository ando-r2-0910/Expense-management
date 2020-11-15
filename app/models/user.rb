class User < ApplicationRecord
  attr_accessor :remember_token
  has_many :book_records, dependent: :destroy
  has_many :daily_balances, dependent: :destroy
  before_save { email.downcase! }
  mount_uploader :img, ImgUploader
  mount_uploader :header_image, HeaderImageUploader
  validates(:name, presence: true, length: { maximum: 20 })
  REGEX_FOR_VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates(:email, presence: true,
                    length: { maximum: 128 },
                    uniqueness: { case_sensitive: false },
                    format: { with: REGEX_FOR_VALID_EMAIL })
  validates :department, length: { in: 2..30 }, allow_blank: true
  validates(:password, presence: true, length: { minimum: 8 }, allow_nil: true)
  has_secure_password

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def set_remember_digest
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?

    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def login_cookie_forget
    update_attribute(:remember_digest, nil)
  end

  def sum_of_amount_for_expenditure
    sum_expenditure = 0
    book_records.each do |record|
      sum_expenditure += record.amount if record.direction == zero
    end
  end

  def sum_of_amount_for_income
    sum_income = 0
    book_records.each do |record|
      sum_income += record.amount if record.direction == 1
    end
  end
  
   # 渡された文字列のハッシュ値を返します。
  def User.digest(string)
    cost = 
      if ActiveModel::SecurePassword.min_cost
        BCrypt::Engine::MIN_COST
      else
        BCrypt::Engine.cost
      end
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返します。
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # 永続セッションのためハッシュ化したトークンをデータベースに記憶します。
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # トークンがダイジェストと一致すればtrueを返します。
  def authenticated?(remember_token)
    # ダイジェストが存在しない場合はfalseを返して終了します。
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # ユーザーのログイン情報を破棄します。
  def forget
    update_attribute(:remember_digest, nil)
  end

end
