App.vote_result = App.cable.subscriptions.create "VoteResultChannel",



  connected: ->
    # Called when the subscription is ready for use on the server
  
  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    #console.log(data)
    if window.counter_ready
      # gather data
      voter_ticket_id = data["ticket_id"]
      voter_team = data["team"]
      red_counter = $('#red-counter')
      # update red counter
      if typeof red_counter isnt 'undefined'
        new_val = data["red"]
        if new_val != window.last_red
          window.last_red = new_val
          if new_val == 0
            red_counter.counter("reset")
          else
            red_counter.counter("count_one",new_val-1)
      # update white counter
      white_counter = $('#white-counter')
      if typeof white_counter isnt 'undefined'
        new_val = data["white"]
        if new_val != window.last_white
          window.last_white = new_val
          if new_val == 0
            white_counter.counter("reset")
          else
            white_counter.counter("count_one",new_val-1)
      # update voter
      if typeof voter_ticket_id isnt 'undefined'
        this.update_voter_msg(voter_ticket_id, voter_team)
    else
      console.log ("counter isn't ready")
      window.hang_data = data

  update_voter_msg: (voter_ticket_id, voter_team) ->
    # ensure array
    if typeof this.red_msg_array isnt 'object'
      this.red_msg_array = []
    if typeof this.white_msg_array isnt 'object'
      this.white_msg_array = []
    # check team
    update_div = $(".counter-group." + voter_team + " .voter")
    if voter_team is "red"
      this.update_voter_msg_to_array(this.red_msg_array,voter_ticket_id,$(".counter-group.red .voter"))
    else
      this.update_voter_msg_to_array(this.white_msg_array,voter_ticket_id,$(".counter-group.white .voter"))

  update_voter_msg_to_array: (array, voter_ticket_id,voter_div) ->
    # check overflow
    if array.length >= 8
      array[array.length-1].hide()
      array.pop()
    # move everybody down

    line = $("<p class='voter-msg'>來自" + voter_ticket_id + "的應援！</p>")
    array.unshift(line)
    voter_div.prepend(line)
    line.fadeIn()


  get_result: () ->
    console.log ("updating")
    @perform 'get_result'

  sleep: (ms) ->
    start = new Date().getTime()
    continue while new Date().getTime() - start < ms



