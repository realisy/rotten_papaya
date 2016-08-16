class Movie < ActiveRecord::Base

  has_many :reviews
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  validates :title,
            presence: true

  validates :director,
            presence: true

  validates :runtime_in_minutes,
            numericality: { only_integer: true }

  validates :description,
            presence: true

  validates :poster_image_url,
            presence: true

  validates :release_date,
            presence: true

  validate :release_date_is_in_the_past

  def review_average
    reviews.sum(:rating_out_of_ten) / reviews.size unless reviews.empty?
  end

  protected

  def release_date_is_in_the_past
    if release_date.present?
      errors.add(:release_date, 'should be in the past') if release_date >
Date.today
    end
  end

end