function ec2() {
	if [ ! -d ~/.ec2 ]; then
		mkdir ~/.ec2
		echo Place EC2 profiles in the newly-created ~/.ec2
		return 0
	fi

	if [ "x$1" = "x" ]; then
		echo Available ec2 profiles:
		ls -1 ~/.ec2
		return 0
	fi

	if [ "$1" = "--clear" ]; then
		ec2_reset
		return 0
	fi

	if [ "$1" = "--reset" ]; then
		ec2_reset
		return 0
	fi


	if [ -f ~/.ec2/$1 ]; then
		#[[ $(stat -f%SMp "$1") =~ .w.$ ]] && echo "Error: $1 is group-writable" && return 1
		#[[ $(stat -f%SLp "$1") =~ .w.$ ]] && echo "Error: $1 is world-writable" && return 1
		echo Switching EC2 profile to $1.
		source ~/.ec2/$1
	else
		echo Profile not defined.
		return 1
	fi
}

function ec2_reset() {
	echo Clearing EC2 profile.
	unset AWS_CREDENTIAL_FILE
	unset AWS_DEFAULT_REGION
	unset AWS_ACCESS_KEY_ID
	unset AWS_SECRET_ACCESS_KEY
	unset AWS_DEFAULT_OUTPUT
	unset AWS_PROFILE
}

# Use this in theme to get profile/region in prompt
function aws_prompt() {
	if [ "x$AWS_PROFILE" = "x" ]; then
		echo ""
	else
		echo "%{$FG[166]%}$AWS_PROFILE%{$reset_color%}/%{$FG[166]%}$AWS_DEFAULT_REGION%{$reset_color%}"
	fi
}

export AWS_PLUGIN=1
