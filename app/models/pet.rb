class Pet < ApplicationRecord
  belongs_to :user
  has_many :chats, dependent: :destroy
  has_many :logs, dependent: :destroy
  has_one_attached :photo

  validates :name, presence: true
  validates :dob, presence: true
  validates :species, presence: true
  validates :breed, presence: true
  validates :vacc_status, presence: true

  # Attribute archived is active by default
  attribute :archived, :boolean, default: false

  # Define a default scope to only show active pet
  default_scope { where(archived: false) }

  # Scope to easily retrieve archived pets
  scope :archived, -> { unscoped.where(archived: true) }

  # Method to archive a pet
  def archive!
    update(archived: true)
  end

  # Method to unarchive a pet
  def unarchive!
    update(archived: false)
  end
end
