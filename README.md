# Squid Cache Signed S3 Objects

This is a proof of concept for caching signed S3 downloads. The example URL is
http://snapshots.linaro.org/android/android-vts/hikey-userdebug/129/MANIFEST,
which returns an HTTP 302 redirect to a signed S3 download. The url on the
download changes every time, so squid needs to strip the signature and return a
cached result.

## Build local squid container with custom configuration

    docker build -t squid .
    docker run -p 3128:3128 -it squid
    /etc/init.d/squid3 start

## Test in a separate shell

First, observe a regular download. Note the 302 redirect and the HTTP headers.

    curl -L -v -o /dev/null http://snapshots.linaro.org/android/android-vts/hikey-userdebug/129/MANIFEST

Then, use the running container as an http proxt:

    export http_proxy=127.0.0.1:3128

Run curl again. It should look much the same as last time, but note the X-Cache header that squid inserted. It should say "MISS".

    curl -L -v -o /dev/null http://snapshots.linaro.org/android/android-vts/hikey-userdebug/129/MANIFEST

Run curl again, and X-Cache should show "HIT".

    curl -L -v -o /dev/null http://snapshots.linaro.org/android/android-vts/hikey-userdebug/129/MANIFEST


