#!/bin/sh
#_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
# Project : Slack notify
# Filename: notify_slack.sh
# Function: Notify Slack Incoming Webhook
# Author: Jimmy, db045
# Update: 2019-01-30 , 23:09
#_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
#
# Send message to your slack incoming webhook by message
#
#

# COMMON Settings
SCRIPTNAME=${0##*/}
SDATE=`date "+%Y-%m-%d-%H%M"`
STIME=`date "+%Y-%m-%d,，%H：%M"`
STIMESTAMP=`date +%s`
SUDOUSER=`printf '%s\n' "${SUDO_USER:-$USER}"`
HOSTNAME=`hostname -s| tr  '[:lower:]' '[:upper:]'`
SYSOS=`uname`
if [  -z "$SYSOS" -a "$SYSOS" != "Linux" ];then
  hostip=`hostname -i`
else
  hostip=`ifconfig|grep inet|head -1|awk '{print $2}'`
fi

# Slack Webhook
# Refer: https://api.slack.com/incoming-webhooks
slack_webhook_url="https://hooks.slack.com/services/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"
slack_title="Message from $HOSTNAME"
slack_bot_name="JJ-Cron-Bot"
slack_icon_emoji=":smiling_imp:"
slack_footer=$HOSTNAME
slack_footer_icon="https://platform.slack-edge.com/img/default_application_icon.png"
slack_opt_text=`whoami`"@"`pwd`

# Check slack webhook
if [ -z $slack_webhook_url ];then echo "slack_webhook_url not found!";exit 1;fi
# Check argument
if [ -z $1 ];then echo "message not found";exit 1;fi
slack_pretext=$1



result=`curl -s --header "Content-Type: application/json" \
  --request POST \
  --data '{ "username": "'"$slack_bot_name"'" ,"icon_emoji": "'"$slack_icon_emoji"'" ,"text": "'"$slack_title"'","icon_emoji": ":vertical_traffic_light:" , \
                "attachments":[ \
                    { \
                        "color": "#36a64f", \
                        "title":  "'"$slack_pretext"'", \
                        "text": "'"$slack_opt_text"'", \
                        "footer":  "'"$slack_footer"'", \
                        "footer_icon":  "'"$slack_footer_icon"'", \
                        "ts": "'"$STIMESTAMP"'", \
                    } \
                ] \
                }' \
  ${slack_webhook_url}`

if [ -z $result ] || [ "$result" != "ok" ];then echo "notify slack failed";else echo "message sent to slack successfully";fi