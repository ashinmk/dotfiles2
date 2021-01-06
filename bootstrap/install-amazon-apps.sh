echo "Authorize using Kerberos please.";
kinit -f;
echo "Authorize using Midway please.";
if [[ "$OSTYPE" == darwin* ]]; then
    mwinit --aea;
else
    mwinit -o;
fi;

toolbox install brazilcli brazil-graph brazil-octane cr gordian-knot;

# Amazon Brew
if [[ "$OSTYPE" == darwin* ]]; then
    brew tap "amazon/amazon" "ssh://git.amazon.com/pkg/HomebrewAmazon"
    brew install ninja-dev-sync;
    echo "You can install a case-sensitive drive by running `setup-case-sensitive-volumes-for-mac.sh`";
fi;
