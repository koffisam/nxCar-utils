#!/bin/bash


# NxCar development dongle setup

# (c) Copyright 2017 Samson Kirk-Koffi (samson@nxcartech.com)

curl -LOk https://github.com/koffisam/nxCar-utils/archive/master.zip
tar -xvzf master.zip 
cd nxCar-utils-master
mv --backup=numbered config /etc/kbd/
mv --backup=numbered dphys-swapfile /etc/