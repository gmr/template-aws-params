# template-aws-params

[![Build Status](https://travis-ci.org/gmr/template-awsparams.svg?branch=master)](https://travis-ci.org/gmr/template-awsparams)

``template-awsparams`` is a tool that uses AWS EC2 Systems Manager (SSM)
[Parameter Store](https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-paramstore.html)
values, along with template files, to render files prior to executing an application. It is intended to be used as a Docker
[Entrypoint](https://docs.docker.com/engine/reference/builder/#entrypoint),
but can really be used to launch applications outside of Docker as well.

The primary goal is to provide a way of creating configuration files for applications that have their configuration 
defined in the SSM Parameter store. It was directly inspired by
[consul-template](https://github.com/hashicorp/consul-template).

## Example Usage

## CLI Options

```
NAME:
   template-aws-params - Application entry-point that renders files using SSM Parameter Store values

USAGE:
   template-awsparams [global options] -p prefix command [command arguments]

COMMANDS:
     help, h  Shows a list of commands or help for one command

GLOBAL OPTIONS:
   --aws-region value        The AWS region to use for the Parameter Store API [$AWS_REGION]
   --prefix value, -p value  Key prefix that is used to retrieve the environment variables - supports multiple use
   --pristine                Only use values retrieved from Parameter Store, do not inherit the existing environment variables
   --sanitize                Replace invalid characters in keys to underscores
   --strip                   Strip invalid characters in keys
   --upcase                  Force keys to uppercase
   --debug                   Log additional debugging information [$PARAMS_DEBUG]
   --silent                  Silence all logs [$PARAMS_SILENT]
   --help, -h                show help
   --version, -v             print the version
```

## Building

This project uses [go modules](https://go.dev/blog/using-go-modules). To build the project:

```bash
go mod download
go mod verify
go build
```

Building an environment is also provided as a docker image based on Alpine Linux. See the Dockerfile for more information.

```bash
docker build -t template-awsparams; # Build the image
docker run --rm -it -v $HOME/.aws/:/root/.aws/ template-awsparams [your options]
```
