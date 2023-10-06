For branch #22 there was an issue with editing files in the wrong branch.

In order to fix this we need to:

```
- git merge "branch-name" (without the parentheses)
# May run into merge conflicts, fix the conflicts in the file. 
# When you are merging you do not have to click commit from "Source Control tab".

- git status

- git add .

- git commit

# Save the file, then close it out for the changes to finish.

- git push
```