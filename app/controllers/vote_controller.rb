class VoteController < ApplicationController
  def result
  end

  def view_red
  end

  def view_white
  end

  def create
    ticket_id = params[:ticket_id].upcase
    team = params["team"]
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
    redirect_to new_vote_path
  end

  def new
  end

end
