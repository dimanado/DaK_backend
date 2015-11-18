class API::V1::MessagesController < WebsocketRails::BaseController
  def create
    byebug
    WebsocketRails.users[myUser.id].send_message('new_notification', { text: message[:text] })
  end
end