# Notice: 

There is now official Microsoft backed Docker image(s) for ASP.NET 5 available:

https://twitter.com/jchannon/status/643689187577884672

https://github.com/aspnet/aspnet-docker


# vagrant-aspnet

A Vagrant container with ASP .NET 5 preconfigured - built to test content scaffolded with [Yeoman ASP NET Generator](https://www.npmjs.com/package/generator-aspnet).
Created to easily follow changes in ASP .NET 5 and overcome problems during beta periods (on my mac machine some latest  ASP .NET projects do not build fully due to misconfiguration - hence that Vagrant box idea was coined).

To use, just clone this repo to your local machine and then invoke `vagrant up`. Note that on the first installation entire `ubuntu/trusty64` image will be downloaded to your local machine.

## Example workflow

Start guest machine:
```
vagrant up
```
Go to `workspace` directory and scaffold ASP .NET project:
```
cd workspace
yo aspnet

     _-----_
    |       |    .--------------------------.
    |--(o)--|    |      Welcome to the      |
   `---------´   |   marvellous ASP.NET 5   |
    ( _´U`_ )    |        generator!        |
    /___A___\    '--------------------------'
     |  ~  |
   __'.___.'__
 ´   `  |° ´ Y `

? What type of application do you want to create? (Use arrow keys)
❯ Empty Application
  Console Application
  Web Application
  Web Application Basic [without Membership and Authorization]
  Web API Application
  Nancy ASP.NET Application
  Class Library
```
Now SSH to your container and go to project directory:
```
vagrant ssh
cd /srv/workspace
```
Restore, build and run ASP .NET project on guest machine:
```
vagrant@vagrant-ubuntu-trusty-64:/srv/workspace/WebApplicationBasic$ dnu restore
Microsoft .NET Development Utility Mono-x64-1.0.0-beta5-12103

Restoring packages for /srv/workspace/WebApplicationBasic/project.json
  CACHE https://www.nuget.org/api/v2/
  GET https://www.nuget.org/api/v2/FindPackagesById()?id='System.Diagnostics.Debug'

  [...]
  
  CACHE https://www.nuget.org/api/v2/package/System.Dynamic.Runtime/4.0.0-beta-23019
  OK https://www.nuget.org/api/v2/FindPackagesById()?id='System.Linq.Expressions' 24330ms
  CACHE https://www.nuget.org/api/v2/package/System.Linq.Expressions/4.0.0-beta-23019
Writing lock file /srv/workspace/WebApplicationBasic/project.lock.json
Restore complete, 26702ms elapsed
```
```
vagrant@vagrant-ubuntu-trusty-64:/srv/workspace/WebApplicationBasic$ dnu build
Microsoft .NET Development Utility Mono-x64-1.0.0-beta5-12103


Building WebApplicationBasic for DNX,Version=v4.5.1
  Using Project dependency WebApplicationBasic 1.0.0
    Source: /srv/workspace/WebApplicationBasic/project.json

  Using Package dependency Microsoft.AspNet.Diagnostics 1.0.0-beta5
    Source: /home/vagrant/.dnx/packages/Microsoft.AspNet.Diagnostics/1.0.0-beta5
    File: lib/dnx451/Microsoft.AspNet.Diagnostics.dll

[...]

  Using Package dependency Microsoft.CodeAnalysis.Analyzers 1.0.0-rc3
    Source: /home/vagrant/.dnx/packages/Microsoft.CodeAnalysis.Analyzers/1.0.0-rc3


Build succeeded.
    0 Warning(s)
    0 Error(s)

Time elapsed 00:00:02.2481114
```
```
vagrant@vagrant-ubuntu-trusty-64:/srv/workspace/WebApplicationBasic$ dnx . kestrel
Started
```
From your host machine navigate to `http://localhost:5000`.



## Configuration

- mono 4.0.1
- libuv 1.4.2
- DNX 1.0.0-beta5
- OS ubuntu/trusty64
- Node, Gulp, Grunt, Bower

## Description

This Vagrant box provisioning tries to create DNVM environment by repeating steps used in various ASP .NET 5 resources:

- [Getting started on Debian: ASP .NET project home](https://github.com/aspnet/Home/blob/dev/GettingStartedDeb.md)
- [Microsoft's ASP .NET Docker image](https://github.com/aspnet/aspnet-docker)
- [Christian Jacobsen's script](https://gist.github.com/chribben/dd0bb057a43f49dc1b5f)

After running `vagrant up` - once SSH-ed into box - you should see this after typing `dnvm`:
```
vagrant@vagrant-ubuntu-trusty-64:~$ dnvm
    ___  _  ___   ____  ___
   / _ \/ |/ / | / /  |/  /
  / // /    /| |/ / /|_/ /
 /____/_/|_/ |___/_/  /_/  

.NET Version Manager - Version 1.0.0-beta6-10395
By Microsoft Open Technologies, Inc.

DNVM can be used to download versions of the .NET Execution Environment and manage which version you are using.
You can control the URL of the stable and unstable channel by setting the DNX_FEED and DNX_UNSTABLE_FEED variables.

Current feed settings:
Default Stable: https://www.nuget.org/api/v2
Default Unstable: https://www.myget.org/F/aspnetvnext/api/v2
Current Stable Override: <none>
Current Unstable Override: <none>

Use dnvm [help|-h|-help|--help]  to display help text.
```

This Vagrant script configures `dnx` and `dnu` tools, sets `beta5` as default version and actually works.

## Example usage

Let's create ASP.NET Basic Web Application:
- scaffold basic web application on your hosting system in `/workspace` directory using `yo aspnet`
- `vagrant ssh` to hosted system
- `cd /srv/workspace` and to directory where you created scaffolded your application
- `dnu restore`
- `dnu build`
- `dnx . kestrel`
- on your hosting system open web browser on this address:  [http://localhost:5000/](http://localhost:5000/):

![Basic Web Application on Ubuntu](https://cloud.githubusercontent.com/assets/14539/8512956/e6c76066-2358-11e5-9882-edc1cca1b072.png)

## Font-end development tools support

This Vagrant box installs Node, Gulp, Grunt and Bower - as new ASP .NET templates ships with package management via Bower and Grunt or Gulp build systems - with Gulp used by default in `generator-aspnet`. So once you SSH into your guest system, go to project directory and invoke NPM and other tools as usually done on hosting system.
```
vagrant@vagrant-ubuntu-trusty-64:/srv/workspace/WebApplicationSimple$ bower install
bower bootstrap#3.0.0           cached git://github.com/twbs/bootstrap.git#3.0.0
bower bootstrap#3.0.0         validate 3.0.0 against git://github.com/twbs/bootstrap.git#3.0.0
bower bootstrap-touch-carousel#0.8.0           cached git://github.com/ixisio/bootstrap-touch-carousel.git#0.8.0
bower bootstrap-touch-carousel#0.8.0         validate 0.8.0 against git://github.com/ixisio/bootstrap-touch-carousel.git#0.8.0
bower hammer.js#2.0.4                          cached git://github.com/hammerjs/hammer.js.git#2.0.4
bower hammer.js#2.0.4                        validate 2.0.4 against git://github.com/hammerjs/hammer.js.git#2.0.4
bower jquery#2.1.4                             cached git://github.com/jquery/jquery.git#2.1.4
bower jquery#2.1.4                           validate 2.1.4 against git://github.com/jquery/jquery.git#2.1.4
bower jquery-validation#1.11.1                 cached git://github.com/jzaefferer/jquery-validation.git#1.11.1
bower jquery-validation#1.11.1               validate 1.11.1 against git://github.com/jzaefferer/jquery-validation.git#1.11.1
bower jquery-validation-unobtrusive#3.2.2      cached git://github.com/aspnet/jquery-validation-unobtrusive.git#3.2.2
bower jquery-validation-unobtrusive#3.2.2    validate 3.2.2 against git://github.com/aspnet/jquery-validation-unobtrusive.git#3.2.2
bower bootstrap-touch-carousel#0.8.0          install bootstrap-touch-carousel#0.8.0
bower hammer.js#2.0.4                         install hammer.js#2.0.4
bower jquery-validation#1.11.1                install jquery-validation#1.11.1
bower jquery#2.1.4                            install jquery#2.1.4
bower bootstrap#3.0.0                         install bootstrap#3.0.0
bower jquery-validation-unobtrusive#3.2.2     install jquery-validation-unobtrusive#3.2.2

bootstrap-touch-carousel#0.8.0 wwwroot/lib/bootstrap-touch-carousel

hammer.js#2.0.4 wwwroot/lib/hammer.js

jquery-validation#1.11.1 wwwroot/lib/jquery-validation

jquery#2.1.4 wwwroot/lib/jquery

bootstrap#3.0.0 wwwroot/lib/bootstrap
└── jquery#2.1.4

jquery-validation-unobtrusive#3.2.2 wwwroot/lib/jquery-validation-unobtrusive
├── jquery#2.1.4
└── jquery-validation#1.11.1
```
