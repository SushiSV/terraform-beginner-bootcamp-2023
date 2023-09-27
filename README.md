# Terraform Beginner Bootcamp 2023

## Semantic Versioning :four_leaf_clover:

This project is going to utilize semantic versioning for its tagging. [semver.org](https://semver.org/)

The general format: **MAJOR.MINOR.PATCH**, eg.`1.0.1`

-  **MAJOR** version when you make incompatible API changes
-  **MINOR** version when you add functionality in a backward compatible manner
-  **PATCH** version when you make backward compatible bug fixes 

## Install the terraform CLI

### Considerations with the Terraform CLI changes
The Terraform CLI Installation instructions have changed due to gpg
keyring changes. So we needed to refer to the latest install CLI
instructions via Terraform Documentation and change the scripting for install.

[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Considerations for Linux Distribution

This project is built against Ubuntu.
Please consider checking your Linux Distribution needs.

[How to check OS version on Linux](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)

Example of checking OS:

```
$ cat /etc/os-release

PRETTY_NAME="Ubuntu 22.04.2 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.2 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"       
UBUNTU_CODENAME=jammy
```

### Refactoring into BASH Scripts

While fixing the Terraform CLI gpg deprecation issues we notice that bash scripts steps were a considerable amount more code. So we decided to create a bash script to install the Terraform CLI.

This bash script is located here: [./bin/install_terraform_cli](./bin/install_terraform_cli)

- This will keep the Gitpod Task File ([.gitpod.yaml](gitpod.yaml)) tidy.
- This allows us an easier to debug and execute manually Terraform CLI install.
- This will allow better portability for other projects that need to install Terraform CLI.

#### SheBang Considerations

A Shebang (pronounced Sha-Bang) tells the bash script what program that will interpret the script. eg. `#!/bin/bash`

ChatGPT recommended this format for bash:`#!/usr/bin/env bash`

- For portability for different OS distribution
- Will search for the user's PATH for the bash execute.

https://en.wikipedia.org/wiki/Shebang_(Unix)

#### Execution Considerations

When executing the script we can use the `./` shorthand notation to execute the bash script.

eg. `./bin/install_terraform_cli`

If we are using a script in .gitpod.yaml we need to point the script to a program to interpret it.

eg. `source ./bin/install_terraform_cli`

#### Linux Permissions Considerations

In order to make our bash scripts executable 

```sh
chmod u+x ./bin/install_terraform_cli
```

Alternatively

```sh
chmod 744 ./bin/install_terraform_cli
```

https://en.wikipedia.org/wiki/Chmod

### Github lifecycle (Before, Init, Command)

We need to be careful when using the Init because it will not run if we restart an existing workspace.

https://www.gitpod.io/docs/configure/workspaces/tasks

### Working Env Vars

We can list out all environment variables (Env Vars) using `env` command\

We can filter out specific env vars using grep. eg. `env | grep AWS_`

#### Setting and unset Env Vars

In the terminal we can **set** using `export HELLO='world'`

In terminal we can **unset** using `unset HELLO`

WE can set an env var temporarily when just running a command.

```sh
HELLO='world' ./bin/print_message
```

Within a bash script we can set env without writing export eg. 

```sh
#!/usr/bin/env bash

HELLO='world'

echo $HELLO
```

#### Printing Vars

We can print an env var using echo eg. `echo $HELLO`

#### Scoping of Env Vars 

When you open new bash terminals in VSCode it will not be aware of env vars that you have set in another window. 

If you want env vars to persist across all future bash terminals that are open you need to set env vars in your bash profile. eg`.bash_profile`

#### Persisting Env Vars in Gitpod

We can persist env vars into gitpod by storing them in Gitpod Secret Storage.

```
gp env HELLO='world'
```

All future workspace launched will set env vars for all bash terminals opened in those workspaces.

You can also set env vars in the `.gitpod.yml` but this can only contain non-sensitive env vars.

### AWS CLI Installation

AWS CLI is installed for the project via the bash script [`./bin/install_aws_cli`](./bin/install_aws_cli)

[Getting started with install (AWS CLI)](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

We can check to see if our aws credentials are configured correctly by running the following AWS CLI command.

```sh
aws sts get-caller-identity
```
If your credentials are not configured then follow this guide:

[AWS CLI ENV VARS](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

**Never put your credentials in the file and commit to Github.**

Instead you want to copy and paste the example under the example and use it to copy and paste into terminal and hit enter:

```
AWS_ACCESS_KEY_ID='AKIAIOSFODNN7EXAMPLE'
AWS_SECRET_ACCESS_KEY='wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY'
AWS_DEFAULT_REGION='us-east-1'

AWS_ACCESS_KEY_ID='YOURACCESSKEY'
AWS_SECRET_ACCESS_KEY='YOURSECRETACCESSKEY'
AWS_DEFAULT_REGION='us-east-1'
```

If succeed you should see a json payload like this.

```json
{
    "UserId": "AIDA6IMYNEHGZBIPZP6JM",
    "Account": "123456789012",
    "Arn": "arn:aws:iam::123456789012:user/terraform-beginner-bootcamp"
}
```