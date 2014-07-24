# Artoo Adaptor For Crazyflie

This repository contains the Artoo (http://artoo.io/) adaptor for the Crazyflie micro-quadcopter (http://www.bitcraze.se/).

Artoo is a open source micro-framework for robotics using Ruby.

For more information abut Artoo, check out our repo at https://github.com/hybridgroup/artoo

The artoo-crazyflie adaptor is based on the crubyflie gem (https://github.com/hsanjuan/crubyflie).

[![Code Climate](https://codeclimate.com/github/hybridgroup/artoo-crazyflie.png)](https://codeclimate.com/github/hybridgroup/artoo-crazyflie) [![Build Status](https://travis-ci.org/hybridgroup/artoo-crazyflie.png?branch=master)](https://travis-ci.org/hybridgroup/artoo-crazyflie)

## Installing

```
gem install artoo-crazyflie
```

## Using

```ruby
require 'artoo'

connection :crazyflie, :adaptor => :crazyflie
device :drone, :driver => :crazyflie, :connection => :crazyflie, :interval => 0.1

work do
  drone.forward(0)
  drone.set_thrust_on
  after(1.seconds) {drone.stop}
end
```

## Connecting to Crazyflie

The Crazyflie uses a 2.4 GHz radio to communicate. There is a USB dongle called the Crazyradio that is required to control the Crazyflie quadcopter.

If you are have a USB 3.0 port, you might run into this issue http://stackoverflow.com/questions/17204253/crazyflie-usb-3-0-incompability

## Crazyflie Hover

To use the Crazyflie beta 'hover' mode, you will need to install the latest beta of firmware to the Crazyflie itself from https://bitbucket.org/bitcraze/crazyflie-firmware/downloads/Crazyflie_2013.11-beta1.bin

Once you have updated the Crazyflie firmware, to trigger the hover mode on, use the `flightmode.althold` param on the Crazyflie like this:

```ruby
  @crazyflie.param.set_value('flightmode.althold', true)
```

Please note that the Crazyflie's interprets hover to mean "maintain altitude", not "stay in one place", so you will need to control horizontal positioning yourself.

To turn hover mode off:

```ruby
  @crazyflie.param.set_value('flightmode.althold', false)
```
Once you turn hover mode off, the Crazyflie requires that you immediately apply thrust, or it will just drop like an unpowered PCB from the air. You have been warned...

## Documentation

Check out our [documentation](http://artoo.io/documentation/) for lots of information about how to use Artoo.

## IRC

Need more help? Just want to say "Hello"? Come visit us on IRC freenode #artoo

## Contributing

* All active development is in the dev branch. New or updated features must be added to the dev branch. Hotfixes will be considered on the master branch in situations where it does not alter behaviour or features, only fixes a bug.
* All patches must be provided under the Apache 2.0 License
* Please use the -s option in git to "sign off" that the commit is your work and you are providing it under the Apache 2.0 License
* Submit a Github Pull Request to the appropriate branch and ideally discuss the changes with us in IRC.
* We will look at the patch, test it out, and give you feedback.
* Avoid doing minor whitespace changes, renamings, etc. along with merged content. These will be done by the maintainers from time to time but they can complicate merges and should be done seperately.
* Take care to maintain the existing coding style.
* Add unit tests for any new or changed functionality.
* All pull requests should be "fast forward"
  * If there are commits after yours use “git rebase -i <new_head_branch>”
  * If you have local changes you may need to use “git stash”
  * For git help see [progit](http://git-scm.com/book) which is an awesome (and free) book on git


(c) 2012-2014 The Hybrid Group
