post '/move' do
  new_move = params[:board]
  player = params[:player]
  random = params[:random]
  Pusher.trigger(PUSHER_CHANNEL, 'new_move', {:new_move => new_move, :player => player, :random => random })
end

post '/pusher/auth' do
 if true
   response = Pusher[params[:channel_name]].authenticate(params[:socket_id], {
       :user_id => rand,
       :user_info => {}
     })
   response.to_json
 else
   status 403
 end
end
