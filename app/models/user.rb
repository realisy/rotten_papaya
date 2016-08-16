class User < ActiveRecord::Base

  has_many :reviews

  has_secure_password

  validates :email,
            presence: true

  validates :firstname,
            presence: true

  validates :lastname,
            presence: true

  validates :password,
            length: { in: 6..20 }, on: :create

  def full_name
    "#{firstname} #{lastname}"
  end

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
end