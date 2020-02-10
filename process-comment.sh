#!/usr/bin/env bash
BODY=$(jq -r .comment.body $GITHUB_EVENT_PATH)
LINES=$(printf "$BODY" | wc -l)
if [ "$LINES" == "0" ]; then
   if  [[ "$BODY" == /* ]]; then
      echo "Command $BODY is received"
      COMMAND=$(echo $BODY | awk '{print $1}' | sed 's/\///')
      if [ -f "commands/$COMMAND.sh" ]; then
         RESPONSE=$("./commands/$COMMAND.sh 2>&1")
      else
         RESPONSE="No such commands \n\n$(./commands/help.sh)"
      fi
      set +x #do not display the GITHUB_TOKEN
      COMMENTS_URL=$(jq -r .issue.comments_url $GITHUB_EVENT_PATH)
      curl -s \
            --data "$(jq --arg body "$RESPONSE" -n '{body: $body}')" \
            --header "authorization: Bearer $GITHUB_TOKEN" \
            --header 'content-type: application/json' \
            $COMMENTS_URL
      else
        echo "No such command: $COMMAND"
        ls -1 commands/
        exit -1
      fi
   fi
fi
