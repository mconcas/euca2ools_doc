#!/bin/bash

EUCA2OOLS_PREFIX=/storage/alice/berzano/euca2ools

export PATH=$EUCA2OOLS_PREFIX/bin:$PATH
export LD_LIBRARY_PATH=$EUCA2OOLS_PREFIX/lib:$LD_LIBRARY_PATH
export PYTHONPATH=$EUCA2OOLS_PREFIX/lib/python2.6/site-packages:$PYTHONPATH

export EC2_URL=https://one-master.to.infn.it/ec2api/

read -p 'Your username: ' EC2_ACCESS_KEY
export EC2_ACCESS_KEY

read -p 'Your password: ' -s EC2_SECRET_KEY
export EC2_SECRET_KEY=$( echo -n "$EC2_SECRET_KEY" | sha1sum | awk '{print $1}' )
echo ''

echo 'Commands start with euca-*, use [Tab] to complete.'
echo 'Type exit to return to your normal shell.'
exec env PS1="$EC2_ACCESS_KEY@cloud-infnto > " bash --norc -i