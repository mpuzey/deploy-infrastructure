"""The purpose of this script it to wrap terraform init to manage s3 keys under the Terraform remote state bucket."""
import argparse
import subprocess
import sys
import os

BASE_PATH = os.path.dirname(os.path.realpath(__file__))


def execute(cmd, path):

    popen = subprocess.Popen(cmd,
                             universal_newlines=True,
                             cwd=path)

    popen.communicate()


def switch_tf_version():
    # Use
    pass


def init(arguments, path):

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
        init_command.append('-backend-config=%s' % line)

    execute(init_command, path)


def get_account_id(arguments):

    process = subprocess.Popen(
        'aws sts get-caller-identity --query \'Account\''
        ' --profile %s --output text' % arguments.project,
        stdout=subprocess.PIPE,
        shell=True)

    encoded_account_id = process.stdout.read()

    return encoded_account_id.decode('utf-8').rstrip()


def validate_component(arguments):

    if arguments.component == 'remote-state':
        print('ERROR: Component cannot be one time remote state bucket!')
        sys.exit(1)


def parse_arguments():

    parser = argparse.ArgumentParser()

    parser.add_argument('--action', help='The Terraform action to perform e.g. plan', required=True)
    parser.add_argument('--project', help='The name of the project e.g. azcard', required=True)
    parser.add_argument('--region', help='The aws region default=eu-west-2', default='eu-west-2')
    parser.add_argument('--environment', help='The aws environment e.g. nonprod', required=True)
    parser.add_argument('--component', help='The terraform component to name the tf state file by', required=True)

    return parser.parse_args()


if __name__ == "__main__":

    args = parse_arguments()

    validate_component(args)

    component_path = os.path.join(BASE_PATH, 'components', args.component)

    init(args, component_path)

    execute(["terraform", args.action], component_path)
