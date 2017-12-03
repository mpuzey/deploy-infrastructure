"""The purpose of this script it to wrap terraform init to manage s3 keys under the Terraform remote state bucket."""
import argparse
import subprocess
import sys
import os
import json

BASE_PATH = os.path.dirname(os.path.realpath(__file__))


def execute(cmd):

    #TODO: add kwargs in order to support passing cwd

    working_dir = os.path.join(BASE_PATH, 'components', 'api-lambda-role')
    popen = subprocess.Popen(cmd,
                             # shell=True,
                             universal_newlines=True,
                             cwd=working_dir)
    popen.communicate()


def get_account_id(arguments):

    process = subprocess.Popen(
        'aws sts get-caller-identity --query \'Account\''
        ' --profile %s --output text' % arguments.project,
        stdout=subprocess.PIPE,
        shell=True)

    encoded_account_id = process.stdout.read()

    return encoded_account_id.decode('utf-8').rstrip()


def switch_tf_version():
    # Use
    pass


def validate_component(arguments):
    if arguments.component == 'remote-state':
        print('ERROR: Component cannot be one time remote state bucket!')
        sys.exit(1)


def init(arguments):
    backend_config_file = open('backend-config.txt', 'r')

    account_id = get_account_id(arguments)

    file_contents = backend_config_file \
        .read() \
        .replace('{project}', arguments.project) \
        .replace('{account_id}', account_id) \
        .replace('{region}', arguments.region) \
        .replace('{environment}', arguments.environment) \
        .replace('{component}', arguments.component) \
        .replace(" ", "") \
        .splitlines()

    init_command = ["terraform", "init"]

    for line in file_contents:
        escaped_string = json.dumps('-backend-config=\'%s\'' % line)
        init_command.append(escaped_string)

    # stringified = 'terraform init -backend-config="bucket=tf-state-553201512970-eu-west-2" -backend-config="key=azcard/553201512970/eu-west-2/test/api-lambda-role.tfstate" -backend-config="region=eu-west-2" -backend-config="profile=azcard"'

    component_path = os.path.join(BASE_PATH, 'components', arguments.component)

    execute(init_command)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()

    parser.add_argument('--action', help='The Terraform action to perform e.g. plan', required=True)
    parser.add_argument('--project', help='The name of the project e.g. azcard', required=True)
    parser.add_argument('--region', help='The aws region e.g. eu-west-2', required=True)
    parser.add_argument('--environment', help='The aws environment e.g. nonprod', required=True)
    parser.add_argument('--component', help='The terraform component to name the tf state file by', required=True)

    args = parser.parse_args()

    validate_component(args)

    init(args)

    # subprocess.run(['terraform', args.action])
