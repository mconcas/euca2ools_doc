Documentation for cloud@torino
==============================

This repository contains the documentation for the Cloud @ INFN Torino.

It is divided in two parts:

*   [Administrators Guide](admin_guide.md)
*   [Users Guide](user_guide.md)


Prerequisites for generating the HTML documentation
---------------------------------------------------

You need the following prerequisites installed on your machine:

*   [pandoc](http://johnmacfarlane.net/pandoc/)
*   [recode](http://recode.progiciels-bpi.ca/index.html)


### Install on Mac OS X

Install [Homebrew](http://brew.sh/), then:

	brew install haskell-platform recode
	cabal install pandoc

You need to set your environment correctly:

	export PATH=$HOME/.cabal/bin:$PATH


### Install on Ubuntu

	apt-get install pandoc recode


How to generate the documentation
---------------------------------

Just type `make`.

If you have proper permissions, you can upload it to the
[publishing address](http://www.to.infn.it/~berzano/cloud) by running
`make upload`.
