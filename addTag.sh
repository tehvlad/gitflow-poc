#!/bin/bash
dt=$(date '+%d/%m/%Y %H:%M:%S')
echo "$dt"
dotnet-gitversion >> stack.json
SEMVER=$(dotnet-gitversion | jq ."SemVer" | sed 's/"//g')
NV=$(dotnet-gitversion | jq ."NuGetVersion" | sed 's/"//g')
Branch=$(git branch --show-current)
echo -e "$dt - $SEMVER - $NV - $Branch" | cat - stack.log > temp && mv temp stack.log
tail stack.log
git add .
git commit -m "$Branch $SEMVER $dt"
git push

# echo dotnet-gitversion | jq ."NuGetVersion" | sed 's/"//g'