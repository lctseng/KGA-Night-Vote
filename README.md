## KGA Voting System 雄友之夜投票系統

* Ruby 2.2.4 & Rails 5.0.0.beta3

* 需要使用Redis

* 設定
  * 此系統使用了ActionCable，Deploy時須修改ActionCable相關的設定
  * 檔案
    * config/environments/production.rb
    * config/environments/developement.rb
  * 修改處
  ```
  config.action_cable.url
  config.action_cable.allowed_request_origins
  ```

* [Heroku App 測試](https://kga-vote.herokuapp.com/)

* 功能
  * 投票
    * (root)或/vote/new

  * 檢視投票結果
    * 紅組: /vote/red
    * 白組: /vote/white
    * 雙方: /vote/result

  * 控制後台(無存取控制)
    * /vote/settings


