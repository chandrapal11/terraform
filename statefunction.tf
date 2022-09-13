# Create IAM role for AWS Step Function
resource "aws_iam_role" "iam_for_sfn" {
  name = "stepFunctionSampleStepFunctionExecutionIAM"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "states.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}


resource "aws_iam_policy" "policy_dynamodb" {
  name        = "stepFunctionfordynamodb"

  policy = jsonencode(
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "dynamodb:PutItem",
                "dynamodb:DescribeTable",
				"dynamodb:Query",
				"dynamodb:UpdateItem",
				"dynamodb:ConditionCheckItem",
				"dynamodb:GetItem",
            ],
            "Resource": "*"
        }
    ]
})
}

// Attach policy to IAM Role for Step Function
resource "aws_iam_role_policy_attachment" "iam_for_sfn_attach_policy_dynamodb" {
  role       = "${aws_iam_role.iam_for_sfn.name}"
  policy_arn = "${aws_iam_policy.policy_dynamodb.arn}"
}



// Create state machine for step function
resource "aws_sfn_state_machine" "sfn_state_machine" {
  name     = "list-state-machines"
  role_arn = "${aws_iam_role.iam_for_sfn.arn}"
    definition = jsonencode ({
		Comment = "Task Lock"
		StartAt = "CheckLock"
		States = {
		  CheckLock = {
	        Type     = "Task"
	        Resource = "arn:aws:states:::dynamodb:putItem"
	        Parameters = {
		      TableName = var.table_name
		      Item = {
			    Task   = { S = "sucess" }
                #Locked = { BOOL = "true" }
		}
	}
     Next = "RemoveLock"
          } 
 RemoveLock = {
	Type     = "Task"
	Resource = "arn:aws:states:::dynamodb:deleteItem"
	Parameters = {
		TableName = var.table_name
		Key = {
			Task = { S = "lock removed" }
		}
	}
	End = true
 }
        }
    }
    )
}
