Euca2ools' how to - Elastic IP configuration
============================================

The purpose of this "how to" is to give the basic tools for managing your own set of virtual machines.
For a more complete documentation see also:

*   [This Guide](http://www.eucalyptus.com/docs/eucalyptus/3.3/console-guide/ "Eucaliptus User Guide")
*   [These FAQs](https://aws.amazon.com/ec2/faqs/ "Amazon EC2 FAQ")

*Please note that from this point forward, we assume that you have an active account on the
cloud, with EC2 credentials and environment variables properly configured.
If you are having problems setting them up please follow [this link](link/to/guide "Setup the environment.") 
or contact your system adminsitrator.
In this chapter we also assume that you are quite familiar with the "elastic IP" concept, at least for associating private VMs' IP addresses to public IP addresses (so reachable from the internet), provided by your cloud service.*

"euca-allocate-addresses"
-------------------------

In order to access a specific elastic IP (from now: eIP), the public one that you are intended to use to access your VM, the first step is *to allocate* one.
Example:

    [user@one-master ~]$ euca-allocate-address
    ADDRESS 193.205.66.212

Please note that:

*   Restricted to the opennebula cloud infrastructure @Turin you have only one IP address to associate. 
*   One cannot choose which address will be allocated. OpenNebula will return one of your "allocable" addresses.
*   If all the available eIPs are allocated, the *euca-allocate-address* command will fall in timeout. 

"euca-describe-addresses"
-------------------------

According with your permissions, this command lists all your *allocated* addresses. Note that if nothing is returned, you wouldn't be able to associate any eIP. 

"euca-associate-addresses"
--------------------------

Syntax is like:

    [user@one-master ~]$ euca-associate-address -i <instance_id> <eIP_address>

Please note: 

*   You can associate an address only whether it was previously allocated. Done that you should be able to connect through *ssh* to your node using the eIP as address if it is configured to do that.
*   Recalling this command changing the \<instance_id\> will automatically associate that instance with the same eIP address, disabling the previously set configuration. 
*   This procedure can be repeated as many times as you want. 
 
"euca-disassociate-addresses"
-----------------------------

You can disassociate whenever you want your VM's instance from the eIP just specifying which one.
E.g:

    [user@one-master ~]$ euca-disassociate-address 193.205.66.212
    ADDRESS 193.205.66.212

"euca-release-addresses"
------------------------

To release an eIP use:

    [user@one-master ~]$ euca-release-address 193.205.66.212
    ADDRESS 193.205.66.212


