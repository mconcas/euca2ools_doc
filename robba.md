[mconcas@one-master cartella_temporanea]$ onevrouter-generator.rb --username pippo --public-ip 173.194.40.31 --priv-ip 172.16.123.0/
255.255.255.0  #go

We are going to create a User with her own VRouter, Pub and Prv network with the following parameters:

 * User name        : pippo
 * Public IP        : 173.194.40.31
 * Public Hostname  : mil02s06-in-f31.1e100.net
 * Private IP range : 172.16.123.0..172.16.123.255

NOTE: template files will be created for the network and VRouter, but no change will be committed to OpenNebula.

Is this OK? Type "yes, it is":


2)




Generating template pippo.onequota...ok
Generating template pippo-VRouter.onevm...ok
Generating template pippo-Prv.onevnet...ok
Generating template pippo-Pub.onevnet...ok

You should create the user with quota like this:

  oneuser create pippo password
  oneuser quota pippo pippo.onequota

Then you should annotate User ID and Private VNet ID and add an ACL like this:

  oneacl create "#<UserID> NET/#<PrivateVNetID> USE+MANAGE"

where you will substitute <UserID> and <PrivateVNetID>
[mconcas@one-master cartella_temporanea]$ ls -l
totale 16
-rw-rw-r-- 1 mconcas mconcas   41 22 ago 17:52 pippo.onequota
-rw-rw-r-- 1 mconcas mconcas  327 22 ago 17:52 pippo-Prv.onevnet
-rw-rw-r-- 1 mconcas mconcas   82 22 ago 17:52 pippo-Pub.onevnet
-rw-rw-r-- 1 mconcas mconcas 2199 22 ago 17:52 pippo-VRouter.onevm
[mconcas@one-master cartella_temporanea]$


3) 


[oneadmin@one-master newuser]$ onevrouter-generator.rb -u ilgius --public-ip 193.205.66.219 --priv-ip 172.16.219.0/24

We are going to create a User with her own VRouter, Pub and Prv network with the following parameters:

 * User name        : ilgius
 * Public IP        : 193.205.66.219
 * Public Hostname  : cloud-gw-219.to.infn.it
 * Private IP range : 172.16.219.0..172.16.219.255

NOTE: template files will be created for the network and VRouter, but no change will be committed to OpenNebula.

Is this OK? Type "yes, it is": asd
Exiting
[oneadmin@one-master newuser]$
[oneadmin@one-master newuser]$
[oneadmin@one-master newuser]$ onevrouter-generator.rb -u ilgius --public-ip 193.205.66.219 --priv-ip 172.16.219.0/24 --commit

We are going to create a User with her own VRouter, Pub and Prv network with the following parameters:

 * User name        : ilgius
 * Public IP        : 193.205.66.219
 * Public Hostname  : cloud-gw-219.to.infn.it
 * Private IP range : 172.16.219.0..172.16.219.255

NOTE: changes will be committed directly to OpenNebula!

Is this OK? Type "yes, it is": yes, it is
Creating user ilgius...ok (user ID: 40)
Adding user ilgius to group 106...ok
Adding a default user quota for ilgius...Creating private network ilgius-Pub...ok (vnet ID: 105)
Creating public network ilgius-Prv...ok (vnet ID: 106)
Creating ACLs...ok (acl ID: 127)
Instantiating VM ilgius-VRouter...ok (VM ID: 3383)
[oneadmin@one-master newuser]$




4) 


create a keypair