Euca2ools' how to - Admin's reference
=====================================

The purpose of this "how to" is to give the basic tools for managing your cloud using the a small set of custom scripts and the Euca2ools, an open source implementation of EC2 Amazon's tools.

For a more complete documentation see also:

*   [This Guide](http://www.eucalyptus.com/docs/eucalyptus/3.3/console-guide/ "Eucaliptus User Guide")
*   [These FAQs](https://aws.amazon.com/ec2/faqs/ "Amazon EC2 FAQ")

Create a new user with the onevrouter-create.rb script
------------------------------------------------------

The script requires three mandatory parameters and one optional parameter.
The basic idea is to assign a VRouter for each virtual private network assigned at every user.
During the execution this script may produce (choosing the default --no-commit option) four templates, one for the quota management, one for the virtual router, one for a private network (where user machines will be connected), and the last for a public network.
It has only one public (elastic) IP visible from the user side. The task automatically accomplished by the euca2ools is to map the unique public IP belonging to this VNet to a private VM's IP belonging to a private VNet.

See how to use it below:

    [oneadmin@one-master ~]$ onevrouter-generator.rb --username clouduser --public-ip 173.194.40.31 --priv-ip 172.16.123.0/255.255.255.0  

    We are going to create a User with her own VRouter, Pub and Prv network with the following parameters:

    * User name        : clouduser
    * Public IP        : 173.194.40.31
    * Public Hostname  : mil02s06-in-f31.1e100.net
    * Private IP range : 172.16.123.0..172.16.123.255

    NOTE: template files will be created for the network and VRouter, but no change will be committed to OpenNebula.

    Is this OK? Type "yes, it is": yes, it is

In this way you create only the four templates, confirm typing literally *yes, it is*
Please note that them will be created in the *present working directory*.
The routine proceeds like this:

    Generating template clouduser.onequota...ok
    Generating template clouduser-VRouter.onevm...ok
    Generating template clouduser-Prv.onevnet...ok
    Generating template clouduser-Pub.onevnet...ok
    
    You should create the user with quota like this:
    
      oneuser create clouduser password
      oneuser quota clouduser clouduser.onequota
    
    Then you should annotate User ID and Private VNet ID and add an ACL like this:
    
      oneacl create "#<UserID> NET/#<PrivateVNetID> USE+MANAGE"
    
    where you will substitute <UserID> and <PrivateVNetID>

See your templates here in this form:

    [oneadmin@one-master ~]$ ls -l
    totale 16
    -rw-rw-r-- 1 oneadmin oneadmin   41 22 ago 17:52 clouduser.onequota
    -rw-rw-r-- 1 oneadmin oneadmin  327 22 ago 17:52 clouduser-Prv.onevnet
    -rw-rw-r-- 1 oneadmin oneadmin   82 22 ago 17:52 clouduser-Pub.onevnet
    -rw-rw-r-- 1 oneadmin oneadmin 2199 22 ago 17:52 clouduser-VRouter.onevm
    [oneadmin@one-master ~]$

If you are pleased with the work and believe it, you can directly commit the changes to OpenNebula that will automatically create everything is necessary for this configuration.
Please, note that no templates will be written after this procedure.

For example:

    [oneadmin@one-master ~]$ onevrouter-generator.rb -u clouduser --public-ip 193.205.66.219 --priv-ip 172.16.219.0/24
    
    We are going to create a User with her own VRouter, Pub and Prv network with the following parameters:
    
     * User name        : clouduser
     * Public IP        : 193.205.66.219
     * Public Hostname  : cloud-gw-219.to.infn.it
     * Private IP range : 172.16.219.0..172.16.219.255
    
    NOTE: template files will be created for the network and VRouter, but no change will be committed to OpenNebula.
    
    Is this OK? Type "yes, it is": asd
    Exiting
    [oneadmin@one-master ~]$
    [oneadmin@one-master ~]$
    [oneadmin@one-master ~]$ onevrouter-generator.rb -u clouduser --public-ip 193.205.66.219 --priv-ip 172.16.219.0/24 --commit
    
    We are going to create a User with her own VRouter, Pub and Prv network with the following parameters:
    
     * User name        : clouduser
     * Public IP        : 193.205.66.219
     * Public Hostname  : cloud-gw-219.to.infn.it
     * Private IP range : 172.16.219.0..172.16.219.255
    
    NOTE: changes will be committed directly to OpenNebula!
    
    Is this OK? Type "yes, it is": yes, it is
    Creating user clouduser...ok (user ID: 40)
    Adding user clouduser to group 106...ok
    Adding a default user quota for clouduser...Creating private network clouduser-Pub...ok (vnet ID: 105)
    Creating public network clouduser-Prv...ok (vnet ID: 106)
    Creating ACLs...ok (acl ID: 127)
    Instantiating VM clouduser-VRouter...ok (VM ID: 3383)


