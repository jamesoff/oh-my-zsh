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
		echo Switching EC2 profile to $1.
		source ~/.ec2/$1

		if [ -f ~/.ec2/${1}-s3cfg ]; then
			echo s3cfg configuration for $1 detected, symlinking as ~/.s3cfg
			if [ -f ~/.s3cfg -a ! -L ~/.s3cfg ]; then
				if [ -f ~/.ec2/_s3cfg ]; then
					rm ~/.ec2/_s3cfg
				fi
				mv ~/.s3cfg ~/.ec2/_s3cfg && rm -f ~/.s3cfg
				echo Previous ~/.s3cfg backed up to ~/.ec2/_s3cfg
			else
				rm -f ~/.s3cfg 2> /dev/null
			fi
			ln -s ~/.ec2/${1}-s3cfg ~/.s3cfg
		else
			rm -f ~/.s3cfg 2> /dev/null
		fi
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
	unalias ssh 2> /dev/null
	unalias scp 2> /dev/null
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
