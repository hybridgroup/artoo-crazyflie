# Artoo Adaptor For Crazyflie

This repository contains the Artoo (http://artoo.io/) adaptor for the Crazyflie quadcopter (http://www.bitcraze.se/).

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

connection :crazyflie, :adaptor => :crazyflie, :port => 'radio://0/10/250K'
device :drone, :driver => :crazyflie, :connection => :crazyflie

work do
  drone.start
  drone.take_off
  
  after(25.seconds) { drone.hover.land }
  after(30.seconds) { drone.stop }
end
```

## Connecting to Crazyflie

The Crazyflie uses a 2.4 GHz radio to communicate. There is a USB dongle called the Crazyradio that is required to control the Crazyflie quadcopter.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
