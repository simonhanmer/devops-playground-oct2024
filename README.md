# devops-playground-october-2024

## Avoiding system failures with chaos engineering

Welcome to the DevOps Playground October 2024!

This month we're going to explore the world of chaos engineering, using Amazon's [Fault Injection Service](https://aws.amazon.com/fis/) to see how we can simulate failures in our systems and make them more resilient.

The recording of the original live session is available at [YouTube](https://www.youtube.com/watch?v=JnilZv9RvBo).


## Pre-requisites
1. Laptop with internet access
1. For those joining us live on the evening, we'll provide:
    * a Panda identity to use for the workshop.
    * a remote shell session with the following installed
        * Terraform
        * AWS CLI along with access to an AWS account
    * Access to the DevOps Playground AWS account
1. If you're following along in your own time, you'll need:
    * An AWS account
    * Terraform installed



## Live workshop environments
If you're running the workshop during the live session, you'll be provided with a set of credentials to use.

## Agenda


We'll be performing the following activities:

### Creating base infrastructure
1. [Initial setup](steps/init/README.md) - create base infrastructure in AWS

### Steps
1. [Step 01](steps/step01/README.md) - first experiment with FIS, a simple single server setup.
1. [Step 02](steps/step02/README.md) - second experiment, improving resilience.
1. [Step 03](steps/step03/README.md) - third experiment, full resilience - test to destruction.
1. [Step 04](steps/step04/README.md) - A look at the new lambda FIS functionality.
---

