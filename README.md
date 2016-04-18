# TextSecure client for Sailfish OS

This is a Signal compatible client for Sailfish OS, written in Go and QML.
It builds upon the great [Go textsecure package] (https://github.com/janimo/textsecure) and modified versions of the
minimalistic gui at [http://gitlab.unique-conception.org/thebootroo/mitakuuluu-ui-ng]

This is a project in early alpha stage. It works for me as a daily messenger. But don't expect a stable software!

What works
-----------

 * Phone registration
 * Direct and group messages
 * View received Photos
 * Storing conversations
 * LED Notification on incoming messages (as long as App is running in background)

What is missing
---------------

 * A lot of the usual UI things, like in other messaging clients
 * Contact syncronisation (you have to add contacts in a text file)
 * Most settings that are available in the Android app
 * Encrypted message store
 * Desktop client provisioning/syncing
 * Encrypted phone calls
 * ... and so on

There are still bugs and UI/UX quirks.

Installation
------------

Download and install the Sailfish SDK
[https://sailfishos.org/wiki/Application_Development]

 * Read ALL the documents!

Install golang into mersdk (Sailfish VirtualBox)
[https://github.com/nekrondev/jolla_go]

 * I use golang 1.5 currently. Maybee it also works with golang 1.6
 * Resolve errors ;-)

Setup development environment and get all needed source

 * mkdir -p ~/sailsecure/bin
 * export GOPATH=~/sailsecure
 * export PATH=$PATH:$GOPATH
 * go get github.com/geobra/harbour-sailsecure

Build

 * cd ~/sailsecure/src/github.com/geobra/harbour-sailsecure/ 
 * mb2 -t SailfishOS-armv7hl build -j 2

Install

 * Copy RPMS/harbour-sailsecure*.rpm to your phone
 * devel-su rpm -ivh harbour-sailsecure*.rpm
 * Copy example contacts.yml file to /home/nemo/.config/harbour-sailsecure/


Contributing
------------
Developers are welcome to contribute!
 * Are you familiar with qml? Who can port [https://github.com/janimo/textsecure-qml/qml/] to this project?!
 * Any other contribution would also be great!

Harbour?
--------
This App will hit the Sailfish store, as soon as the contacts syncronisation is working.

