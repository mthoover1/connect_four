$(document).ready(function() {

  var player = 1;

  var pusher = new Pusher('f206b222ae6d845db32e');
  var channel = pusher.subscribe('moves');

  channel.bind('new_move', function(data) {
    // repopulateBoard(data.new_move);
    console.log(data);
    for (var i=1; i<43; i++) {
      var slot = $('#spacer-' + i).children(":first");
      slot.attr('id', data.new_move[i-1]);
      if (data.new_move[i-1] === "1") {
        slot.attr("class", "slot-black");
      }
      if (data.new_move[i-1] === "2") {
        slot.attr("class", "slot-red");
      }
    }

    $.post('/game/checkvictory', {board : returnBoard()}, function(response) {
      console.log(response);
      if (response.winner == 1) {
        $('nav').append("<div id='victory'>Winner is Player " + response.winner + " (Black)!!!</div>");
      }
      if (response.winner == 2) {
        $('nav').append("<div id='victory'>Winner is Player " + response.winner + " (Red)!!!</div>");
      }
    });

    player = data.player;
  });


  $('.slot').click(function() {
    if ($(this).hasClass("slot")) {
      if (player == 1) {
        $(this).attr("class", "slot-black");
        $(this).attr("id", "1");

        player = 2;

        $.post('/move', { board: returnBoard(), player: player, random: "HELLO" });
      }
      else {
        $(this).attr("class", "slot-red");
        $(this).attr("id", "2");

        player = 1;

        $.post('/move', { board: returnBoard(), player: player, random: "HEEHAW" });
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

function convertDomToString() {

}
