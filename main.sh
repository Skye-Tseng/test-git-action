branch="switch"
updated_file="hello.yaml"
today=$(date +%F)


echo "- hello world" > $updated_file

if [ -f "$updated_file" ];
then
  yaml_path=$updated_file
  git checkout -b $branch
  sudo apt install -y yamllint
  yamllint -d relaxed --no-warnings $yaml_path
else
  echo "No updated file exits."
  exit 0
fi

if [[ $(git diff --stat) != '' ]];
then
  sudo apt update
  sudo apt install gh
  git config --global user.email "skyetseng@17.media"
  git config --global user.name "github-actions-bot"
  git add $updated_file
  git commit -m "[Test] Hello file sync"
  git push -f --set-upstream origin $branch

  pr_url=$(gh pr create --title "[Test] Hello file sync" --body $today)

  # 沒merge情形
  current_branch_pr_status=$(gh pr view --json 'state' -q '.state' | xargs) # 沒merge
  if [[ $current_branch_pr_status != 'OPEN' ]];
  then
    echo "one"
    pr_url=$(gh pr create --title "[Test] Hello file sync" --body $today)
  else
    echo "two"
    pr_exists_msg="PR already exists, just go to merge ${branch} branch directly."
  fi
else
  echo 'File unchanged.'
fi