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

We'll need to generate AWS CLI credits form IAM User in order to use AWS CLI.

If your credentials are not configured then We will need to generate AWS CLI credits from IAM User in order to use AWS CLI.

Guide to configure AWS CLI: [AWS CLI ENV VARS](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

**Never put your credentials in the file and commit to Github.**

**Good practice is to rotate your access key and secret access keys.**

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

## Terraform Basics

### Terraform Registry

Terraform sources their providers and modules from the Terraform registry which is located at [registry.terrform.io](https://registry.terraform.io/)

- **Providers** is a interface to APIs that will allow resources to be created in terraform.
- **Modules** are a way to refactor or to make large amounts of terraform code modular, portable and shareable.

[Random Terraform Provider](https://registry.terraform.io/providers/hashicorp/random/latest)

## Terraform Console

We can see a list of all the terraform commands by typing `terrraform`.

#### Terraform Init

At the start of a new terraform project we will run `terrform init` to download the binaries for the terraform providers that we used in this project.

#### Terraform Plan

`terraform plan`

This will generate out a changeset, about the state of our infrastructure and what will be changed.

We can output this changeset ie. "plan" to be passed to an apply, but often you can just ignore outputting.

#### Terraform Apply

`terraform apply`

This will run a plan and pass the changeset to be executed by terraform. Apply should prompt us yes or no.

If we want to automatically approve an apply we can provide the auto approve flag eg. `terraform apply --auto-approve`

#### Terraform Destroy

`terraform destroy`

This command is use to destroy resources.

#### Terraform Lock Files

`.terraform.lock.hcl` contains the lock versioning for the providers or modules that should be used with this project.

The Terraform Lock File should be committed to you Version Control System (VCS) eg. Github

#### Terraform State Files

`.terraform.tfstate` contains information about the current state of your infrastructure.

This file should ***NOT*** be committed to your VCS.

This file can contain sensitive data.

If you lose this file, you lose the state of your infrastructure.

`.terraform.tfstate.backup` is the previous state of the file state. Basically a back up.

#### Terraform Directory

`.terraform` directory contains binaries of terraform providers.

## Issues with Terraform Cloud Login and Gitpod Workspace

When attempting to run `terraform login` it will launch bash a wiswig view to generate a token. However it does not work expected in Gitpod VsCode in the browser.

The workaround is manually generate a token in Terraform Cloud

```
https://app.terraform.io/app/settings/tokens?source=terraform-login
```

Then create open the file manually here:

```sh
touch /home/gitpod/.terraform.d/credentials.tfrc.json
open /home/gitpod/.terraform.d/credentials.tfrc.json
```

Provide the following code (replace your token in the file):

```json
{
  "credentials": {
    "app.terraform.io": {
      "token": "YOUR-TERRAFORM-CLOUD-TOKEN"
    }
  }
}
```

After creating a token and entering your token into the json file.  You could also run into an error when trying to `terraform init`. You may get a error that looks like this:

<img width="838" alt="Screenshot_20231004_052301" src="https://github.com/SushiSV/terraform-beginner-bootcamp-2023/assets/111544292/ca760bde-e08e-475e-a46c-165f0e46af23">

This means that your local terraform version does not match the remote terraform and will cause incompatibility issues.

To solve this problem we need to head into terraform.io.

`terraform.io > try terraform cloud > workspaces > terra-house-1` <img width="838" alt="terraform 1" src="https://github.com/SushiSV/terraform-beginner-bootcamp-2023/assets/111544292/09911737-13ee-4fa3-862c-b605c5e24755">`

While in terra-house-1, look on the left panel and click on settings
<img width="838" alt="terraform 2" src="https://github.com/SushiSV/terraform-beginner-bootcamp-2023/assets/111544292/0c33fee7-5602-4251-8b4d-e909426f0651">

While you are in settings scroll down until you come across `Terraform Version` then select the version accodingly.
<img width="838" alt="terraform 3" src="https://github.com/SushiSV/terraform-beginner-bootcamp-2023/assets/111544292/5c523647-bd85-4186-9872-42caaa721e11">

This should allow you to contintue with `terraform init` to complete your configurations.