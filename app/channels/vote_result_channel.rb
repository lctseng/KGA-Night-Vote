# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class VoteResultChannel < ApplicationCable::Channel

  def self.send_result(option_data = {})
    ActionCable.server.broadcast 'vote_result_channel', (::VoteHelper.get_vote_result).merge!(option_data)
  end

  def subscribed
    stream_from "vote_result_channel"
    get_result
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def get_result
    self.class.send_result
  end

end
