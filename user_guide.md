Euca2ools' how to - Cloud-enter.sh
==================================

The purpose of this "how to" is to give the basic tools for managing 
your own set of virtual machines.
For a more complete documentation see also:

*   [EC2 FAQs](https://aws.amazon.com/ec2/faqs/ "Amazon EC2 FAQ")

*Please note that from this point forward, we assume that you have an
active account on the cloud, If you are encountering problems setting
them up please contact your system administrator.*

How to use "cloud-enter.sh" from a *public login machine*
---------------------------------------------------------

Once logged in your account you can find ```cloud-enter.sh``` script
in this path 

```/storage/alice/berzano/euca2ools/bin/cloud-enter```

Or, for convenience, put an alias into your ~/.cshrc file.
Type:

```{.sh}
echo "alias cloud-enter \
/storage/alice/berzano/euca2ools/bin/cloud-enter" \
>> ~/.cshrc
```
Then execute your ```.cshrc``` and type: 

    ~$> cloud-enter
    Your username: user
    Your password:
    Commands start with euca-*, use [Tab] to complete.
    Type exit to return to your normal shell.
    user@cloud-infnto [~]>

From this prompt you can run the *euca-commands*. 
Enjoy...


Euca2ools' howto - VM managing
===============================

"euca-create-keypairs"
----------------------

In order to access by ssh you can create a keypair. Note that this 
command require a -f \<keyfile_name.pem\> and a name that is to be 
specified during the VM's creation (see below how to run an istance).

```{.sh}
euca-create-keypairs -f <keyfile_name.pem> keyfile_name
```

"euca-describe-keypairs"
------------------------
This lists all the keypairs you have created.

"euca-describe-images" List the VM images available.
----------------------------------------------------
Example:

```{.sh}
$> euca-describe-images
IMAGE	ami-00000304	cvm-2.7.1	    oneadmin	available	public		i386	machine
IMAGE	ami-00000322	cvm-2.7.1-ami	oneadmin	available	public		i386	machine
```

This will list all the images you can run. The unique ID 
"ami-xxxxxxxx" is the parameter you need to specify
in order to run the chosen image.

"euca-run-instances" Run your VM from available images list.
------------------------------------------------------------
In order to be able to launch instances you have to choose flavor 
and eventually specify a contextualization script.

*   Usually three flavors are available: *m1.small, m1.medium and 
    m1.large*. According with your quota limits you can choose the 
    flavor you prefer.
    Each template has different specification about the resources 
    your VM will have.
    Example: 

    1.   ```m1.small: ```  1 VCPU(s), 512 MB RAM, 0  GB DISK 
    2.   ```m1.medium: ``` 2 VCPU(s),   2 GB RAM, 20 GB DISK
    3.   ```m1.large: ```  4 VCPU(s),   8 GB RAM, 80 GB DISK 

*   The second (optional) parameter you might need to specify is your
    contextualization script.
    This mainly depends on which technology you chose to implement.

*   Optionally you can set the number of machines you would create, with the parameter ```-n```

The command may result, for example:

```{.sh}
$> euca-run-instances ami-xxxxxxxx -k keypair_name -n <number_of_instances> -f path/to/<userdata_file> -t m1.small
```

See also: ```man euca-run-instances``` for more explanations.

"euca-describe-instances" List your running instances.
------------------------------------------------------
As you can easily figure out, this command allows you to list 
__your__ running instances. Here you can see your instances ami-IDs,
status, etc.
This is how does it work:

```{.sh}
$> euca-describe-instances
RESERVATION default mconcas default
INSTANCE    i-kkkkkkkk  ami-xxxxxxxx    172.16.212.4    172.16.212.4    pending none    3374        m1.small    2013-08-14T14:41:38+02:00   default eki-EA801065    eri-1FEE1144        monitoring-disabled     172.16.212.4
INSTANCE    i-zzzzzzzz  ami-yyyyyyyy    172.16.212.5    172.16.212.5    running none    3375        m1.medium    2013-08-14T14:41:39+02:00   default eki-EA801065    eri-1FEE1144        monitoring-disabled     172.16.212.5 
```

Note that from here one can obtain your instance ID, which is 
necessary due to "interaction" through the Euca2ools 
(e.g. save snapshots, stop, start your instance).

"euca-{start,stop}-instances" Start and Stop instances
------------------------------------------------------
Again, these commands are used to change VMs' statuses, starting,
stopping them.
A stopped machine can be restarted with the command:

```{.sh}
$> euca-start-instances <instance_id>
```

Euca2ools' howto - Elastic IP configuration
============================================

"euca-allocate-addresses"
-------------------------

In order to access a specific elastic IP (from now: eIP), the public 
one that you are intended to use to access your VM, the first step 
is *to allocate* one.
Example:

```{.sh}
$> euca-allocate-address
ADDRESS 193.205.66.212
```

Please note that:

*   Restricted to the opennebula cloud infrastructure @Turin you 
    have only one IP address to associate. 
*   One cannot choose which address will be allocated. 
    OpenNebula will return one of your "allocable" addresses.
*   If all the available eIPs are allocated, 
    the *euca-allocate-address* command will fall in timeout. 

"euca-describe-addresses"
-------------------------

According with your permissions, this command lists all your 
*allocated* addresses. Note that if nothing is returned, you 
wouldn't be able to associate any eIP. 

"euca-associate-addresses"
--------------------------

Syntax is like:

```{.sh}
$> euca-associate-address -i <instance_id> <eIP_address>
```

Please note: 

*   You can associate an address only whether it was 
    previously allocated. Done that you should be able to connect 
    through *ssh* to your node using the eIP as address.
*   Recalling this command changing the \<instance_id\> will 
    automatically associate that instance with the same eIP address, 
    disabling the previously set configuration. 
*   This procedure can be repeated as many times as you want. 
 
"euca-disassociate-addresses"
-----------------------------

You can disassociate whenever you want your VM's instance from the 
eIP just specifying which one.
E.g:

```{.sh}
$> euca-disassociate-address 193.205.66.212
ADDRESS 193.205.66.212
```

"euca-release-addresses"
------------------------

To release an eIP use:

```{.sh}
$> euca-release-address 193.205.66.212
ADDRESS 193.205.66.212
```
    



