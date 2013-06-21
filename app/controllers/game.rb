post '/movered' do
  move = params[:move]
  Pusher.trigger(PUSHER_CHANNEL, 'move-red', {:move => move })
end

post '/moveblack' do
  move = params[:move]
  Pusher.trigger(PUSHER_CHANNEL, 'move-black', {:move => move })
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
