"""The purpose of this script it to wrap terraform init to manage s3 keys under the
    Terraform remote state bucket."""
import argparse
from subprocess import Popen, PIPE
import sys
import os

BASE_PATH = os.path.dirname(os.path.realpath(__file__))


def handle():

    args, tf_vars = parse_arguments()
    validate_component(args)
    component_path = os.path.join(BASE_PATH, 'components', args.component)
    init(args, component_path)
    action(args, component_path, tf_vars)


def parse_arguments():

    parser = argparse.ArgumentParser()

    parser.add_argument('--action', help='The Terraform action to perform e.g. plan', required=True)
    parser.add_argument('--project', help='The name of the project default=<your_project_name>', default='<your_project_name>')
    parser.add_argument('--profile', help='The name of the AWS profile default=default', default='default')
    parser.add_argument('--region', help='The aws region default=eu-west-2', default='eu-west-2')
    parser.add_argument('--environment', help='The aws environment e.g. test', required=True)
    parser.add_argument('--component', help='The terraform component to name the tf state file by', required=True)

    return parser.parse_known_args()


def validate_component(arguments):

    if arguments.component == 'remote-state':
        print('ERROR: Component cannot be one time remote state bucket!')
        sys.exit(1)


def switch_tf_version():
    # Use terraform 0.11
    pass


def init(arguments, path):

    backend_config_file = open('backend-config.txt', 'r')

    account_id = get_account_id(arguments)

    file_contents = backend_config_file \
        .read() \
        .replace('{project}', arguments.project) \
        .replace('{profile}', arguments.profile) \
        .replace('{account_id}', account_id) \
        .replace('{region}', arguments.region) \
        .replace('{environment}', arguments.environment) \
        .replace('{component}', arguments.component) \
        .replace(' ', '') \
        .splitlines()

    init_command = ['terraform', 'init']

    for line in file_contents:
        init_command.append('-backend-config=%s' % line)

    execute(init_command, path, arguments)


def get_account_id(arguments):

    process = Popen(
        'aws sts get-caller-identity --query \'Account\''
        ' --profile %s --output text' % arguments.project,
        stdout=PIPE,
        shell=True)

    encoded_account_id = process.stdout.read()

    return encoded_account_id.decode('utf-8').rstrip()


def action(arguments, path, vars=None):

    command = ['terraform', arguments.action]

    if vars:
        for var_string in vars:
            command.append('-var')
            command.append(var_string)

    print(command)
    execute(command, path, arguments)


def execute(cmd, path, arguments):

    # This env var provides a workaround for the following issue:
    # https://github.com/hashicorp/terraform/issues/13589
    env_vars = dict(os.environ, AWS_PROFILE=arguments.project)

    process = Popen(cmd,
                    universal_newlines=True,
                    cwd=path,
                    env=env_vars,
                    stdin=PIPE)

    process.communicate(input="yes")

    if process.returncode != 0:
        sys.exit(1)


if __name__ == '__main__':
    handle()
