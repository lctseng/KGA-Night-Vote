module VoteHelper


  def self.get_vote_result
    {
      type: 'result',
      red: REDIS.get("vote_result.red").to_i,
      white: REDIS.get("vote_result.white").to_i,
    }
  end


  def check_id_valid?(ticket_id)
    !REDIS.hget("ticket_info",ticket_id).nil?
  end

  def check_voted?(ticket_id)
    state = REDIS.hget("ticket_info",ticket_id)
    state && !state.empty?
  end

  def check_team_valid?(team)
    ["red","white"].include? team
  end

  def start_voting?
    start_time = REDIS.get("kga.start_vote_time")
    if start_time
      start_time = Time.parse(start_time)
    else
      start_time = Time.new(2016,5,25,18,30)
    end
    end_time = REDIS.get("kga.end_vote_time")
    if end_time
      end_time = Time.parse(end_time)
    else
      end_time = Time.new(2016,5,25,20,30)
    end
    now = Time.now
    return now >= start_time && now <= end_time
  end

  # team should be either "red" or "white"
  # assume ticket_id is valid and not voted
  def do_vote(ticket_id,team)
    # record as vote
    REDIS.hset("ticket_info",ticket_id,team)
    # vote it!
    REDIS.incr("vote_result.#{team}")
  end

  # ==admin==
  def self.reset_all
    reset_all_ticket
    clear_vote
  end

  def self.clear_vote
    REDIS.multi do |multi|
      REDIS.set("vote_result.red",0)
      REDIS.set("vote_result.white",0)
    end
    VoteResultChannel.send_result
  end


  def self.reset_all_ticket
    REDIS.multi do |multi|
      # clear redis
      multi.del("ticket_info")
      # setup tickets
      generate_ticket_id.each do |ticket_id|
        multi.hset("ticket_info",ticket_id,"") # not voted
      end  
    end
  end

  def self.generate_ticket_id
    #return TICKET_LIST
    # FIXME! for test
    arr = []
    676.times do |i|
      arr << sprintf("%06d",i+1)
    end
    return arr
  end

  # for testing
  def self.force_vote(team,val = 1)
    REDIS.incrby("vote_result.#{team}",val)
    VoteResultChannel.send_result({:team => team, :ticket_id => sprintf("AB%03d",rand(999)) } )
  end

  def self.random_voting(count = 100)
    count.times do 
      force_vote(["red","white"].sample,1)
      sleep (rand / 2)
    end
  end

  def self.voting_state(ticket_id = nil)
    if ticket_id
      REDIS.hget("ticket_info",ticket_id)
    else
      REDIS.hkeys("ticket_info").collect do |key|
        [key,voting_state(key)]
      end.sort_by {|data| data[0]}
    end
  end

end
