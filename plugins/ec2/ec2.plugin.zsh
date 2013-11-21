function ec2() {
	if [ ! -d ~/.ec2 ]; then
		mkdir ~/.ec2
		echo Place EC2 profiles in the newly-created ~/.ec2
		return 0
	fi

	if [ "$1" = "clear" ]; then
		echo Clearing EC2 profile.
		unset AWS_CREDENTIAL_FILE
		unset AWS_DEFAULT_REGION
		unset AWS_ACCESS_KEY_ID
		unset AWS_SECRET_ACCESS_KEY
		unset AWS_DEFAULT_OUTPUT
		
		return 0
	fi

	if [ "x$1" = "x" ]; then
		echo Available ec2 profiles:
		ls -1 ~/.ec2
		return 0
	fi

	if [ -f ~/.ec2/$1 ]; then
		echo Switching EC2 profile to $1.
		source ~/.ec2/$1
	else
		echo Profile not defined.
		return 1
	fi
}
