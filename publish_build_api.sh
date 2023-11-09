curl --location 'https://api.prismacloud.io/policy' \
--header 'accept: application/json' \
--header 'content-type: application/json' \
--header 'x-redlock-auth: {token}' \
--data '{
    "autoRemediable": false,
    "cloudType": "all",
    "findingTypes": [],
    "complianceMetadata": [],
    "description": "",
    "labels": [],
    "name": "API-TEST-BUILD",
    "policyType": "config",
    "recommendation": "",
    "remediation": null,
    "policySubTypes": [
        "build"
    ],
    "rule": {
        "name": "API-TEST-BUILD",
        "children": [
            {
                "metadata": {
                    "code": "---\nmetadata:\n  name: \"API-TEST-BUILD\"\n  severity: \"medium\"\n  guidelines: \"fix it\"\n  category: general\nscope:\n  provider: aws\ndefinition:\n  or:\n    - and:\n      - cond_type: attribute\n        resource_types: [\"AWS::SQS::QueuePolicy\"]\n        attribute : PolicyDocument.Statement[0].Condition.Bool.\"aws:SecureTransport\"\n        operator: jsonpath_exists\n      - cond_type: attribute\n        resource_types: [\"AWS::SQS::QueuePolicy\"]\n        attribute : PolicyDocument.Statement[0].Condition.Bool.\"aws:SecureTransport\"\n        operator: jsonpath_equals\n        value: true\n    - or:\n      - and:\n        - cond_type: attribute\n          resource_types: [\"aws_sqs_queue_policy\"]\n          attribute: policy.Statement.Condition.Bool.aws:SecureTransport\n          operator: exists\n        - cond_type: attribute\n          resource_types: [\"aws_sqs_queue_policy\"]\n          attribute: policy.Statement.Condition.Bool.aws:SecureTransport\n          operator: is_true"
                },
                "type": "build"
            }
        ],
        "parameters": {
            "savedSearch": "false",
            "withIac": "true"
        },
        "type": "Config"
    },
    "severity": "medium"
}'
