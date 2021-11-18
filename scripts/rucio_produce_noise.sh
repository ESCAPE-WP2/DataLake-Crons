#!/bin/bash

cd /scripts/Utilities-and-Operations-Scripts/rucio-noise
git pull origin master

echo '* Rucio Produce Noise START*'

bash rucio_produce_noise.sh

echo '* Rucio Produce Noise DONE*'
