#!/bin/bash
find /tftpboot -type f -print0 | xargs -0 chmod 644
find /tftpboot -type d -print0 | xargs -0 chmod 755
