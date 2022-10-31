# frozen_string_literal: true

class Property < ApplicationRecord
  CLEANING_FEE = 2_000.freeze
  CLEANING_FEE_MONEY = Money.new(CLEANING_FEE)
  SERVICE_FEE_PERCENTAGE = (0.09).freeze

  validates :name, presence: true
  validates :headline, presence: true
  validates :description, presence: true
  validates :address_1, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :country, presence: true

  has_many_attached :images, dependent: :destroy

  has_many :reviews, as: :reviewable
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  has_many :reservations, dependent: :destroy
  has_many :reserved_users, through: :reservations, source: :user

  monetize :price_cents, allow_nil: true

  geocoded_by :address
  after_validation :geocode, if: -> { latitude.blank? && longitude.blank? }

  def address
    # [address_1, address_2, city, state, country].compact.join(', ') faker addresses are not real
    [state, country].compact.join(', ')
  end

  def default_image
    images.first
  end

  def favorited_by?(user)
    return if user.nil?

    favorited_users.include?(user)
  end

  def available_dates
    date_format = '%b %e'

    next_reservation = reservations.future_reservations.first
    return Date.tomorrow.strftime(date_format)..Date.today.end_of_year.strftime(date_format) if next_reservation.nil?

    Date.tomorrow.strftime(date_format)..next_reservation.reservation_date.strftime(date_format)
  end
end
