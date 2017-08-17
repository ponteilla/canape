# canape
A tool to manage your [Parsec](https://parsec.tv) AWS instance.

It provisions an AWS GPU instance with the Parsec AMI at a [Spot price](https://aws.amazon.com/ec2/spot/pricing/).
Handy for rainy weekends.

## Requirements

- AWS CLI
- Terraform

If you are on Mac and have Homebrew installed, simply run `brew install awscli terraform`.

## Usage

[Make sure your AWS CLI is set up with your credentials](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html).
You will also need the `server_key` from your [Parsec configuration settings](https://parsec.tv/account).

1. Initialise AWS resources for your instance: `./canape build server_key`
2. Start it: `./canape start`
3. When you are done, terminate it: `./canape stop`
