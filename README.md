# kickstarter_bot
bot

# required
- Docker

# .env for Slack Notification 

```
vim .env
SLACK_TOKEN=xorg-######
```

# environment for kickstarter reward url, item, Slack channel
- main.rb
```
$slack_channel = "#general"
$go_url = "https://www.kickstarter.com/projects/dazz3dprinter/dazz-3d-the-most-advanced-lcd-sla-3d-printer?ref=user_menu"
$reward_id = 6805561
```

# run container
```
sh run.sh
```
