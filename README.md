# vagrant-aspnet
A Vagrant container with ASP .NET 5 preconfigured

This Vagrant box provisioning tries to create DNVM environment by repeating steps descripbed on [ASP.NET home project wiki about Linux containers](https://github.com/aspnet/Home/blob/dev/GettingStartedDeb.md):
- [Get Mono](https://github.com/aspnet/Home/blob/dev/GettingStartedDeb.md#get-mono)
- [Get libuv](https://github.com/aspnet/Home/blob/dev/GettingStartedDeb.md#get-dnvm)
- [Get DNVM](https://github.com/aspnet/Home/blob/dev/GettingStartedDeb.md#get-dnvm)

After all steps are completed you, once SSH-ed into box, you should see this after typing `dnvm`:
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
