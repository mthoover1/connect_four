// <div id="#" class="slot"><p class="hidden">0</p></div>


$(document).ready(function() {

  var pusher = new Pusher('f206b222ae6d845db32e');
  var channel = pusher.subscribe('moves');

  channel.bind('move-black', function(data) {
    alert("move black");
  });

  channel.bind('move-red', function(data) {
    alert("move red");
  });

  var player = 1;

  $('.slot').click(function() {
    if ($(this).hasClass("slot")) {
      if (player === 1) {
        $(this).attr("class", "slot-black");
        $(this).attr("id", "1");

        $.post('/moveblack', returnBoard());

        player = 2;
      }
      else {
        $(this).attr("class", "slot-red");
        $(this).attr("id", "2");

        $.post('/movered', returnBoard());

        player = 1;
      }
    }
  });


  function returnBoard() {
    var boardString = ""
    for (var i=1; i<43; i++) {
      var value = $('#spacer-' + i).children(":first");
      boardString = boardString + (value.attr('id'));
    }
    return boardString;
  }

  presenceChannel = pusher.subscribe('presence-moves');
  presenceChannel.bind('pusher:subscription_succeeded', function(members) {
    online = members.count
  });

  presenceChannel.bind('pusher:member_added', function(member) {
    online += 1;
  });

  presenceChannel.bind('pusher:member_removed', function(member) {
    online -= 1;
  });
});
