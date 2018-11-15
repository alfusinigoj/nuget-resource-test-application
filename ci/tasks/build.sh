#!/bin/bash
cd app-repo

echo I am in `pwd`
ls -l ../

echo "starting build ..."

dotnet restore -r ubuntu.14.04-x64
dotnet publish -f netcoreapp1.0 -r ubuntu.14.04-x64 -o ./publish

echo "copying files to ../build-output"
cp manifest.yml ../build-output

wget -c https://github.com/miclip/dotnet-extensions/releases/download/v0.7/dotnet-ext-linux.tar.gz -O dotnet-ext-linux.tar.gz 
tar -xvzf dotnet-ext-linux.tar.gz

echo list dir

chmod +x ./bin/dotnet-pack-ext 
chmod +x ./bin/dotnet-nuget-ext

cp ./bin/dotnet-pack-ext /usr/local/bin/
cp ./bin/dotnet-nuget-ext /usr/local/bin/


dotnet pack-ext --version

dotnet pack-ext simple ./NugetResource.TestApplication.csproj 
 --version-spec "1.0.0" --basepath ./publish --no-publish --no-build --source https://www.myget.org/F/dotnet-resource-test/api/v3/index.json`

cp *.nupkg ../build-output