# Log a worklog
curl --request POST \
  --user <username>@<domain>.com:<api_token> \
  --header 'Accept: application/json' \
  --header 'Content-Type: application/json' \
  --data '
    {
      "author": {
        "accountId": "string",
        "active": true,
        "avatarUrls": {},
        "displayName": "string",
        "emailAddress": "string",
        "key": "string",
        "name": "string",
        "self": "string",
        "timeZone": "string"
      },
      "comment": "string",
      "created": "string",
      "id": "string",
      "issueId": "string",
      "properties": [
        {
          "key": "string",
          "value": "unknown"
        }
      ],
      "self": "string",
      "started": "string",
      "timeSpent": "string",
      "timeSpentSeconds": 123456,
      "updateAuthor": {},
      "updated": "string",
      "visibility": {
        "type": "string",
        "value": "string"
      }
    }' \
  --url 'https://<your org name>.atlassian.net/rest/api/2/issue/{issueIdOrKey}/worklog'

# See my tasks 
# NB: the field might be to tweek a little bit
curl --request POST \
  --user <username>@<domain>.com:<token or pwd> \
  --header 'Accept: application/json' \
  --header 'Content-Type: application/json' \
  --data '
    {
      "jql": "assignee = currentUser() AND sprint in openSprints()",
      "startAt": 0,
      "maxResults": 30,
      "fields": [
        "summary",
        "status",
        "assignee",
        "worklog"
      ],
      "fieldsByKeys": false
    }' \
  --url 'https://<your org name>.atlassian.net/rest/api/2/search'


# See general tasks (to be reviewed)
# GEN-3: Onboarding
# GEN-5: Vacation
# GEN-26: Hackathon
# GEN-27: Computer setup
# GEN-36: Blitz
# GEN-45: Code review
# GEN-46: Various meetings
curl --request POST \
  --user <username>@<domain>.com:<token> \
  --header 'Accept: application/json' \
  --header 'Content-Type: application/json' \
  --data '
  {
  "jql": "issue in (\"GEN-3\", \"GEN-5\", \"GEN-26\", \"GEN-27\", \"GEN-36\", \"GEN-45\", \"GEN-46\")",
  "startAt": 0,
  "maxResults": 30,
  "fields": [
    "summary",
    "status",
    "assignee",
    "worklog"
  ],
  "fieldsByKeys": false
}
  ' \
  --url 'https://<your org name>.atlassian.net/rest/api/2/search'


# See my day
## from this call you should receive issues on which there are worklogs from the current user attached to it
## this should be parsed to display the aggregated time spent on tasks for the current day (ADUI-19: 2h, GEN-45: 1h, etc)
curl --request POST \
  --user <username>@<domain>.com:<token> \
  --header 'Accept: application/json' \
  --header 'Content-Type: application/json' \
  --data '
  {
  "jql": "workLogAuthor = currentUser() AND sprint in openSprints()",
  "startAt": 0,
  "maxResults": 1000,
  "fields": [
    "summary",
    "status",
    "assignee",
    "worklog"
  ],
  "fieldsByKeys": false
}
  ' \
  --url 'https://<your org name>.atlassian.net/rest/api/2/search'



# See my week
## same as "See my day" but parse json per day, NOT per JIRA task
## from this call you should receive issues on which there are worklogs from the current user attached to it
## this should be parsed to display the aggregated time logged per day for a specific week or sprint
