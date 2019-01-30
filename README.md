# Notify Slack Webhook
## Usage:
$./notify_slack.sh YOUR_MESSAGE

## Customize
You can define your own variables above **\# Slack Webhook variables** section:
```
slack_webhook_url="YOUR_SLACK_WEBHOOK_URL"
slack_title="Message from $HOSTNAME"
slack_bot_name="YOUR_NAME"
slack_icon_emoji=":smiling_imp:"
slack_footer=$HOSTNAME
slack_footer_icon="https://platform.slack-edge.com/img/default_application_icon.png"
slack_opt_text=`whoami`"@"`pwd`
```
