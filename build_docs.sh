#!/bin/sh

# building directly to the mounted build dir fails b/c of user permissions
SC_DOCS_BUILD_DIR="/root/scdocs_build" sclang build_docs.scd

echo "Apply adjustments for deployment"
# make Help.html also the index.html site
cp /root/scdocs_build/Help.html /root/scdocs_build/index.html
# redirect local source file links to source files on github
find /root/scdocs_build/ -type f -exec sed -i -e 's_file:///usr/local/share/SuperCollider/SCClassLibrary/_https://github.com/supercollider/supercollider/tree/develop/SCClassLibrary/_g' {} \;
find /root/scdocs_build/ -type f -exec sed -i -e 's_file:///usr/local/share/SuperCollider/HelpSource/_https://github.com/supercollider/supercollider/tree/develop/HelpSource/_g' {} \; 
find /root/scdocs_build/ -type f -exec sed -i -e 's_/usr/local/share/SuperCollider/build/Install/share/SuperCollider/SCClassLibrary/_https://github.com/supercollider/supercollider/tree/develop/SCClassLibrary/_g' {} \; 
find /root/scdocs_build/ -type f -exec sed -i -e 's_/usr/local/share/SuperCollider/HelpSource_https://github.com/supercollider/supercollider/tree/develop/HelpSource_g' {} \; 
echo "Copy CSS patch"
cp /root/custom.css /root/scdocs_build/custom.css

echo "Move from the intermediate folder to the host build folder"
cp -r /root/scdocs_build/* /root/scdocs

echo "Finished"
