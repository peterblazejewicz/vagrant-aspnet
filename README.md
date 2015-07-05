# vagrant-aspnet
A Vagrant container with ASP .NET 5 preconfigured - built to test content scaffolded with [Yeoman ASP NET Generator](https://www.npmjs.com/package/generator-aspnet).

## Configuration

- mono 4.0.1
- libuv 1.4.2
- DNX 1.0.0-beta5
- OS ubuntu/trusty64

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
- scaffold basic web application in your hosting system `/workspace` directory using `yo aspnet`
- `vagrant ssh` to hosted system
- `cd /srv/workspace` and to directory where you created scaffolded your application
- `dnu restore`
- `dnu build`
- `dnx . kestrel`
- on your hosting system open web browser to [http://localhost:5000/](http://localhost:5000/):

![Basic Web Application on Ubuntu](https://cloud.githubusercontent.com/assets/14539/8512956/e6c76066-2358-11e5-9882-edc1cca1b072.png)

## TODO
Node/NPM and Gulp/Grunt installed as CLI tools, as they are used by client-side build tools in most recent versions of ASP .NET templates. At the moment they are not required, as production/staging configuration for web project templates used CND based resources.
