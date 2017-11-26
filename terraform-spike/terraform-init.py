"""The purpose of this script it to wrap terraform init to manage s3 keys under the Terraform remote state bucket."""
import argparse, sys

parser=argparse.ArgumentParser()

parser.add_argument('--project', help='The name of the project e.g. azcard')
parser.add_argument('--account_id', help='The aws account id')
parser.add_argument('--region', help='The aws region e.g. eu-west-2')
parser.add_argument('--environment', help='The aws environment e.g. nonprod')
parser.add_argument('--component', help='The terraform component to name the tf state file by')

args=parser.parse_args()

print(args)

backend_config_file = open('backend-config.tf', 'r')

file_contents = backend_config_file.read()

# file_contents.replace()

# TODO: called terraform init with the args
