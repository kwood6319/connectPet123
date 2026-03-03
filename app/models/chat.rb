class Chat < ApplicationRecord
  belongs_to :owner, class_name: "User"
  belongs_to :vet, class_name: "User"
  belongs_to :pet, -> { unscope(where: :archived) } # Allow verification of archived pets
  has_many :messages, dependent: :destroy
  accepts_nested_attributes_for :messages

  # Attribute archived is active by default
  attribute :archived, :boolean, default: false

  # Define a default scope to only show active chats
  default_scope { where(archived: false) }

  # Scope to easily retrieve archived chats
  scope :archived, -> { unscoped.where(archived: true) }

  # Method to archive a chat
  def archive!
    update(archived: true)
  end

  # Method to unarchive a chat
  def unarchive!
    update(archived: false)
  end
end
