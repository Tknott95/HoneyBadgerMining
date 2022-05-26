#!/bin/bash


# lolminer_dl_link=https://objects.githubusercontent.com/github-production-release-asset-2e65be/155006859/e583d010-66d8-4d32-986b-d29af719fb96?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20220526%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220526T122854Z&X-Amz-Expires=300&X-Amz-Signature=bbd9acddf47e09d4dd493ac7a044202497d6c97cbe22555881ffaf54bbfceef7&X-Amz-SignedHeaders=host&actor_id=15900491&key_id=0&repo_id=155006859&response-content-disposition=attachment%3B%20filename%3DlolMiner_v1.51a_Lin64.tar.gz&response-content-type=application%2Foctet-stream


mkdir lolminer

cd lolminer

# curl -O $lolminer_dl_link

tar -xzf *.tar.gz

cd */
ls -la


chmod +x lolMiner
./lolMiner
