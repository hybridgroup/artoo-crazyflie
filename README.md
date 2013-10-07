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

To use Crazyflie with the hover command, requires installing the https://bitbucket.org/omwdunkley/crazyflie-firmware fork of the Crazyflie firmware. The easiest way to currently do this, is to install the Crazyflie PC Client, download the 'hover' branch BIN file from here https://bitbucket.org/omwdunkley/crazyflie-firmware/downloads/cflie.bin and then use the Crazyflie PC tools to update the Crazyflie firmware.

Once you have updated the Crazyflie firmware, you will NEED to use the following syntax in your Artoo code to use it:

```ruby
connection :crazyflie, :adaptor => :crazyflie, :supports_hover => true
```

If you do not use `supports_hover => true` in your connection code tto the Crazyflie, it will go crazy out of control. You have been warned...
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
