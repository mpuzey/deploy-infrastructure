"""The purpose of this script it to wrap terraform init to manage s3 keys under the Terraform remote state bucket."""
import argparse
import subprocess

parser = argparse.ArgumentParser()

parser.add_argument('--project', help='The name of the project e.g. azcard', required=True)
parser.add_argument('--account_id', help='The aws account id', required=True)
parser.add_argument('--region', help='The aws region e.g. eu-west-2', required=True)
parser.add_argument('--environment', help='The aws environment e.g. nonprod', required=True)
parser.add_argument('--component', help='The terraform component to name the tf state file by', required=True)

args = parser.parse_args()

backend_config_file = open('backend-config.tf', 'r')

file_contents = backend_config_file \
    .read() \
    .replace('{project}', args.project) \
    .replace('{account_id}', args.account_id) \
    .replace('{region}', args.region) \
    .replace('{environment}', args.environment) \
    . replace(" ", "") \
    .splitlines()

init_command = ["terraform", "init"]

for line in file_contents:
    init_command.append("-backend-config=%s" % line)

subprocess.run(init_command)
