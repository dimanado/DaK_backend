WebsocketRails::EventMap.describe do
  namespace :message do
    subscribe :create, to: API::V1::MessagesController, with_method: :create
  end
end
