#!/bin/sh

# Set Pin-29(PWR_SEQ2) to GPIO
devmem 0x0502707c 32 0x111
devmem 0x03001068 32 0x3

# Set Pin-19(SD0_PWR_EN) to GPIO
devmem 0x0300101c 32 0x3
