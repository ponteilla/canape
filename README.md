# canape
A tool to manage your [Parsec](https://parsec.tv) AWS instance. It provisions an AWS GPU instance (g2.2xlarge) with the Parsec AMI at a [Spot price](https://aws.amazon.com/ec2/spot/pricing/). At the moment, only 4 AWS regions are supported: `eu-west-1`, `eu-central-1`,`us-west-1`, `us-east-1`.

Handy for rainy weekends.

## Requirements

- AWS CLI
- Terraform

If you are on OS X and use Homebrew, just `brew install awscli terraform`

## Usage

[Make sure your AWS CLI is set up with your credentials](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html).

You will also need the `server_key` from Parsec. Go to the [Add your own gaming computer](parsecgaming.com/add-computer/own) page and "click here to see extra steps".

1. Initialise AWS resources for your instance: `./canape.sh build eu-west-1 0.20 server_key`
2. Start it: `./canape.sh start`
3. When you are done playing, terminate the instance: `./canape.sh stop`
4. Destroy all config and AWS resources: `./canape.sh destroy`
