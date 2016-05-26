class VotesController < ApplicationController
  layout "voting", :only => [:new]

  def result
  end

  def view_red
  end

  def view_white
  end

  def create
    ticket_id = params[:ticket_id].upcase
    team = params["team"]
    if start_voting?
      if check_id_valid?(ticket_id)
        if !check_voted?(ticket_id)
          if check_team_valid?(team)
            do_vote(ticket_id, team) 
            flash[:info] = "投票成功！"
            VoteResultChannel.send_result({ticket_id: ticket_id, team: team})
          else
            flash[:info] = "無效的選項，請選擇您想支持的隊伍"
          end
        else
          flash[:info] = "您已經投過票囉!"
        end
      else
        flash[:info] = "無效的票卷號碼"
      end
    else
      flash[:info] = "目前不在投票時間!"
    end
    redirect_to new_vote_path
  end

  def new
  end


  def get_settings
    time = REDIS.get("kga.start_vote_time")
    if time
      @start_time = Time.parse(time).strftime("%Y-%m-%dT%H:%M:%S")
    else
      @start_time = nil
    end
    time = REDIS.get("kga.end_vote_time")
    if time
      @end_time = Time.parse(time).strftime("%Y-%m-%dT%H:%M:%S")
    else
      @end_time = nil
    end

  end

  def post_settings
    case params["command"]
    when "reset"
      case params["commit"]
      when "重置全部"
        VoteHelper.reset_all
      when "票數歸零"
        VoteHelper.clear_vote
      when "清除投票紀錄"
        VoteHelper.reset_all_ticket
      end
    when "vote"
      if params["value"]
        val = session["value"] = params["value"].to_i
      else
        val = 0
      end
      case params["commit"]
      when "強制投紅組"
        VoteHelper.force_vote "red", val
      when "強制投白組"
        VoteHelper.force_vote "white", val
      when "隨機投票"
        VoteHelper.random_voting val
      end
    when "time"
      case params["commit"]
      when "設定"
        timeval = Time.parse(params["time"]).strftime("%Y-%m-%d %H:%M:%S")
      when "清除"
        timeval = nil
      end
      redis_key = "kga.#{params["time_type"]}_vote_time"
      if timeval
        REDIS.set(redis_key, timeval)
      else
        REDIS.del(redis_key)
      end
    end
    redirect_to settings_vote_path
  end



end
