#!/usr/bin/env bash
#doc: Dismiss all the blocking reviews by github-actions bot
MESSAGE="Blocking review request is removed."
URL="$(jq -r '.issue.pull_request.url' $GITHUB_EVENT_PATH)/reviews"
curl -s https://api.github.com/repos/elek/comment-controll/pulls/1/reviews \
    | jq -r '.[] | [.user.login, .id] | @tsv' \
    | grep github-actions \
    | awk '{print $2}' \
    | xargs -n1 -IISSUE_ID curl -s \
       -X PUT \
       --data "$(jq --arg message "$MESSAGE" -n '{message: $message}')" \
       --header "authorization: Bearer $GITHUB_TOKEN" \
       $URL/ISSUE_ID/dismissals

