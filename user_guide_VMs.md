Euca2ools' how to - VM managing
===============================

The purpose of this "how to" is to give the basic tools for managing your own set of virtual machines.
For a more complete documentation see also:

*   [This Guide](http://www.eucalyptus.com/docs/eucalyptus/3.3/console-guide/ "Eucaliptus User Guide")
*   [These FAQs](https://aws.amazon.com/ec2/faqs/ "Amazon EC2 FAQ")

*Please note that from this point forward, we assume that you have an active account on the
cloud, with EC2 credentials and environment variables properly configured.
If you are having problems setting them up please follow [this link](link/to/guide "Setup the environment.") 
or contact your system administrator.*

"euca-describe-images" List the VM images available.
-------------------------------------------------------
 Example:

    [user@one-master]$ euca-describe-images
    IMAGE	ami-00000304	cvm-2.7.1	    oneadmin	available	public		i386	machine
    IMAGE	ami-00000322	cvm-2.7.1-ami	oneadmin	available	public		i386	machine

This will list all the images you can run. The unique ID "ami-xxxxxxxx" is the parameter you need to specify
in order to run the chosen image.

*Tip: The Euca2ools don't use OpenNebula's identification codes, even they are similar.*

"euca-run-instances" Run your VM from available images list.
---------------------------------------------------------------
In order to be able to launch instances you have to choose flavor and eventually specify a contextualization script.

*   Usually three flavors are available: *m1.small, m1.medium and m1.large*. According with your quota limits you can choose the flavor you prefer.
    Each template has different specification about the resources your VM will have.
    Example: 

    1.   __m1.small__: 1 VCPU(s), 512 MB RAM, 0  GB DISK 
    2.   __m1.medium__: 2 VCPU(s),   2 GB RAM, 20 GB DISK
    3.   __m1.large__: 4 VCPU(s),   8 GB RAM, 80 GB DISK 

*   The second (optional) parameter you might need to specify is your contextualization script.
    This mainly depends on which technology you chose to implement.


The command may result, for example:

    [user@one-master ~]$ euca-run-instances ami-xxxxxxxx -f path/to/<userdata_file> -t m1.small

See also: "man euca-run-instances" for more explanations.

"euca-describe-instances" List your running instances.
---------------------------------------------------------
As you can easily figure out, this command allows you to list __your__ running instances. Here you can see your instances ami-IDs, status, etc.
This is how does it work:

    [user@one-master ~]$ euca-describe-instances
    RESERVATION default mconcas default
    INSTANCE    i-kkkkkkkk  ami-xxxxxxxx    172.16.212.4    172.16.212.4    pending none    3374        m1.small    2013-08-14T14:41:38+02:00   default eki-EA801065    eri-1FEE1144        monitoring-disabled     172.16.212.4
    INSTANCE    i-zzzzzzzz  ami-yyyyyyyy    172.16.212.5    172.16.212.5    running none    3375        m1.medium    2013-08-14T14:41:39+02:00   default eki-EA801065    eri-1FEE1144        monitoring-disabled     172.16.212.5 

Note that from here one can obtain your instance ID, which is necessary due to "interaction" through the Euca2ools (e.g. save snapshots, stop, start your instance).

"euca-{start,stop}-instances" Start and Stop instances
---------------------------------------------------------
Again, these commands are used to change VMs' statuses, starting, stopping them.
A stopped machine can be restarted with the command:

    [user@one-master ~]$ euca-start-instances <instance_id>



    



