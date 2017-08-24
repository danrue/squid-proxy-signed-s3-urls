# Squid Cache Signed S3 Objects

## Build local squid container with custom configuration

    docker build -t squid .
    docker run -p 3128:3128 -it squid

## Test in a separate shell

First, observe a regular download. Note the 302 redirect and the HTTP headers.

    curl -L -v -o /dev/null http://snapshots.linaro.org/android/android-vts/hikey-userdebug/129/MANIFEST

Then, use the running container as an http proxt:

    export http_proxy=127.0.0.1:3128

Run curl again. It should look much the same as last time, but note the X-Cache header that squid inserted. It should say "MISS".

    curl -L -v -o /dev/null http://snapshots.linaro.org/android/android-vts/hikey-userdebug/129/MANIFEST

Run curl again, and X-Cache should show "HIT".

    curl -L -v -o /dev/null http://snapshots.linaro.org/android/android-vts/hikey-userdebug/129/MANIFEST


