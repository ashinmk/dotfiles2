## Add Midway Pass to Keychain. This is safe and InfoSec approved.

stty -echo; # Secure input
printf "Enter Midway Password: ";
read midway_pass;
stty echo;
printf "\n"

security add-generic-password -a $USER -s midway -w "$midway_pass";

unset midway_pass;

## Add SSH key
ssh-keygen;
