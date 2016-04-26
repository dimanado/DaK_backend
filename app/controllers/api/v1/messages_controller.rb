class API::V1::MessagesController < WebsocketRails::BaseController
  def create
    debugger;
    WebsocketRails.users["chatChannel_#{message[:channel]}"].send_message('message.create', { text: message[:text] })
  end
end