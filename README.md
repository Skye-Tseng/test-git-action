# test-git-action

curl --request POST \
  --url 'https://api.github.com/repos/Skye-Tseng/test-git-action/dispatches' \
  --header 'authorization: Bearer [TOKEN]' \
  --data '{"event_type": "hey"}'