#!/usr/bin/python
import yum,sys,subprocess

nrpe_packages = ['epel-release', 'nrpe', 'nagios-plugins-all']

services = ['nrpe.service']
#Defining the function for installing packages from an input list of packages
def install_packages(packages):
    yb= yum.YumBase()
    for package in packages:
        inst = yb.rpmdb.returnPackages()
        installed=[x.name for x in inst]
        if package in installed:
            print "%s is already installed" % package
        else:
            print "Installing %s" % package
            ret = subprocess.call("yum install -y '%s'" % package,shell=True,stdout=open('/dev/null','w'),stderr=subprocess.STDOUT)
            if ret == 0:
                print 'Installed ***%s***' % package
            else:
                print "Failed to install %s" % package
                sys.exit(1)

#Defining the function to remove the installed packages
def remove_packages(packages):
    yb= yum.YumBase()
    inst = yb.rpmdb.returnPackages()
    installed=[x.name for x in inst]
    for package in packages:
        if package in installed:
            print "Removing %s" % package
	    kwarg = { 'name':package  }
            yb.remove(**kwarg)
            yb.resolveDeps()
            yb.buildTransaction()
            yb.processTransaction()
        else:
            print "%s is already uninstalled" % package

#Executing the function for installing packages
install_packages(nrpe_packages)
