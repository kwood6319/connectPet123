class Message < ApplicationRecord
  belongs_to :chat
  belongs_to :user

  validates :contents, presence: true

  def from?(user)
    self.user_id == user.id
  end

  # after_create_commit(*args, &block) => runs after a message is successfully saved to the DB. Will not run if the validation fails
  # broadcast_append_to() => Turbo Streams. Tells Rails to send the message to everyone subscribed to the chat.

  after_create_commit -> {
    broadcast_append_to(
      # Sets the stream name -> each stream will have a unique identifier based on the DB id.
      "chat_#{chat.id}",
      # This is the DOM Id Turbo will append to (add to the bottom) => Turbo will look for <div id="chat-messages"> </div> and add the message above the closing tag
      target: "chat-messages",
      # Tells Rails to render the _message.html.erb
      partial: "messages/message",
      locals: {
        # Passes the newly created message
        message: self
      }
    )
  }
end
