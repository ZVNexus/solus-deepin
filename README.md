# Solus Deepin

## I'm a dragon, hear me roar!

### It is *probably* broken (to varying degrees), and could remain so.

This is an exercise in packaging Deepin.
It is not ready - nor intended - for production use, and it *will not* go into the Solus repos (upstream Solus won't take it, I won't submit it and take on that responsibility).

If you do try this, running it on your production machine is a terrible idea - it'll probably bork a number of things.

***

### TODO

**Apps that run on an otherwise stock Solus (Budgie) install**

- [x] Calculator
- [x] Calendar (though it's pretty much useless)
- [x] File Manager
- [x] Image Viewer
- [x] Movie (VM lacks the correct acceleration I believe, works fine bare metal)
- [x] Music
- [ ] Picker (may not be possible?)
- [ ] Screen Recorder (may not be possible?)
- [x] Screenshot
- [x] System Monitor
- [x] Terminal
- [x] Voice Recorder

***

#### `deepin-daemon`

Need to look into packaging:
* Miracast/Miracle Cast -  [Tarball](https://github.com/linuxdeepin/miraclecast/archive/1.0.8.tar.gz)

Currently stuck with:
```
/home/build/YPKG/root/deepin-miraclecast/build/miraclecast-1.0.8/res/dispctl.vala:807.2-807.18: error: 1 missing arguments for `void GLib.Application.set_default (GLib.Application?)'
	app.set_default();
	^^^^^^^^^^^^^^^^^
Compilation failed: 1 error(s), 2 warning(s)
```

Will try with upstream `miraclecast` and hopefully it'll work.

Add as rundep:
* `imwheel` (used for mouse wheel settings)
* `rfkill` (used with Bluetooth)

Look into:
* missing files from `/usr/share/deepin-default-settings`, see `deepin-default-settings`.

#### `deepin-desktop`

Known tasks:
* Rundeps are mixed up - startdde is probably what wants many of these, desktop is just one of them. This falls under the general mucking out of rundeps that needs to go on.

#### `deepin-default-settings`

Need to package ([Link](https://github.com/linuxdeepin/default-settings)), but be selective - there's a bunch of stuff in there that we *don't* need, or want.
Will need a bit of poking, as such.

#### `deepin-dock` / `deepin-launcher`

Need to investigate:
* using a different icon theme does not change immediately (possibly only when HIDPI is working?)

#### `deepin-file-manager`

Look into packaging:
* [dde-file-manager-integration](https://cr.deepin.io/admin/projects/dde/dde-file-manager-integration)

Need to investigate:
* cannot mount MTP Android device (can only test with Samsung Galaxy S5 currently, but that works under GNOME)

Known tasks:
* `/usr/bin/dde-xdg-user-dirs-update` is not executable. Need to see why and possibly remedy that (as it's a script, it may be run via bash, instead of directly).

#### `deepin-qt5config`

[What is it?](https://cr.deepin.io/#/admin/projects/deepin-qt5config)

#### `startdde`

Look into:
* `startmanager.go:90: open /usr/lib/UIAppSched.hooks/launched: no such file or directory`

#### Misc.

* validate core packages and strip un-needed rundeps (and add those that are required). This one is hard though, we'll see.
* check if `deepin-music` is using vendored libraries and transition off of them if possible.  
* check on how to make sure `setcap cap_kill,cap_net_raw,cap_dac_read_search,cap_sys_ptrace+ep /usr/bin/deepin-system-monitor` is run so that network speed monitoring may be achieved.
* validate touchpad swipe shortcuts (specifically, 4/5 fingered ones, which my current machine does not support), see if I need to drop the Arch patch to `deepin-daemon` (it seems to be a decision to disable 3 finger tapping being intercepted, leaving it open for, say, following links, or pasting, the former being something I use often)
* investigate why first login (at least in VM) has a white bg, as you have to fish for a button.
* check if I can plumb in the control center to link to the Solus SC for updating, and if not, disable the section entirely.
* see if I can force disable the disablement of `deepin-mutter`, temporarily, for the sake of VM testing?
* `dde-dock` (actually, almost eveything Deepin related) often crashes when changing USB devices, need to investigate. Specifically, mouse and keyboard (HDD is okay).
* `deepin-movie` has 'volume down' when it should have 'Volume down', in keyboard shortcuts.

### Updates

*2018-06-11.1* - Upstream put out a point release for `deepin-qt5dxcb-plugin`, so that builds now.
A couple other package updates as well.
For now, unless there's an ABI or other file change, I'll hold off rebuilding (unless I see things are broken, or it's a non-ABI dependant situation, such as `deepin-gir-generator`, etc.).

***

*2018-05-06.1* - Well, I upgraded packages, reinstalled my Deepin packages.
So far, so good... Woot?

***

*2018-05-05.3* - Finally updated and rebuilt all my packages, now to upgrade my system, and then I'll try for a reboot.
All of that can wait for tomorrow.

***

*2018-05-05.2* - Things are nearly done in this round of upgrades.
Would have been a lot quicker if I had better internet...
Oh well.

As explaination, I'm without any fixed line internet, have to use mobile for now.
I get 2GB/month, with about 15KB/s unlimited thereafter.
Well, you can see why it takes a while.
Hopefully, I'll be getting internet shared across from neighbors soon enough.

***

*2018-05-05.1* - Found a fix in master for `dtkwidget`, but the latest version of `deepin-qt5dxcb-plugin` is still borked.
Taking a while, but I'm working on rebuilds (and updating my install of Solus), then we'll try for a reboot and see what happens.

***

*2018-05-04.1* - Updates are being a bitch...
We'll see.
Would be a lot easier with better internet, which *might* happen soonish.

***

*2018-04-29.1* - I'm almost mad, I wish I'd found this sooner - [an official dependancy graph](https://salsa.debian.org/pkg-deepin-team/progress-tracker/blob/master/depgraph/pkg-deepin-dep.svg) from Deepin.
Once I have good internet, I'll go through all packages, cut deps *wayyyy* back, and re-add them as shown.

***

*2018-04-26.2* - I went ahead and am running the current build now.
User icons are gone (?).
For now, fudging things by removing lightdm and replacing with gdm.
I would remove the dependancy between `liblightdm-qt5` and `lightdm`, but that wouldn't be correct, and this is just a short term measure anyway.

***

*2018-04-26.2* - Got my rebuilds done (at last - I'm on a throttled connection).
Not a lot happening on my end until I can test with updates from Solus, once those come out.

***

*2018-04-26.1* - Okay, almost all on upstream git now (just wallpapers left iirc), but things are iffy.
I believe that having rebuilt packages, they rely on Solus updates that are not yet safe to apply (specifically, `lightdm` is borked as far as I can tell).
So, installing `gdm` was enough as a stopgap measure for my Deepin machine to keep it limping along, but it also uninstalled some stuff...

But, of course, `cr.deepin.io` would go down as I try to do rebuilds, wouldn't it...

***

*2018-04-24.1* - Doing the final spree of moving over to upstream git, worked out what's wrong with `deepin-image-viewer` (`freeimage` needed to rebuild, upstream had changed between the two).

***

*2018-04-22.1* - I *would* be working on things, but the SSL cert on the Deepin [dev site](https://cr.deepin.io/) is expired, so building is a no-go until that's resolved.

***

*2018-04-20.1* - Been working through packages, switching from GitHub sources to use upstream git sources (the GH mirrors seem to be frozen at the moment, since about a week ago).
This has the added benefit to me of reducing download overhead when I next upgrade packages, as the majority of the source is going to remain the same.
A few updates are being picked up along the way.

***

*2018-04-15.1* - Just a few updates, nothing big as far as I can tell.
`deepin-image-viewer` stopped building with the latest update to 1.2.19, so I need to sort that out. 

***

*2018-04-05.1* - Got Deepin Movie (Reborn) packaged up, I really like it (for the most part, see further).
Tried it in a VM, it doesn't work solo at this point.
I suspect it's something to do with not having acceleration available.
Will test on bare metal soon(ish?).

Some points against it though:

* it does not support letterboxing when in windowed mode (meaning no split screen viewing, unless your content happens to be a vertical format)
* it does not support any cropping modes, so no trimming off baked letterboxes

***

*2018-04-03.1* - Got a few updates done (was busy over the weekend, and it wasn't urgent, so...), things should be up to date again.
I find a few random application crashes now and again, need to determine if it's to do with my building of the DE (probably not), the DE itself (maybe), or the apps in particular (more likely).

***

*2018-03-26.2* - Did a full rebuild with my scripts, ironed out the last of the run/build_dep file issues.
Also sorted out which apps run solo (and made sure they had the right rundeps), and *started* on a bit of making sure lower level components actually have the rundeps they need (`deepin-daemon` so far has been tested a little)

***

*2018-03-26.1* - Things are going to slow down now, reasons being:
* I've gotten the main desktop done, it's mainly peripheral apps now. If updates come out, I'll try to make sure I upgrade and all that.  
* I'm going to be busy (getting a job), I won't have a ton of time to dump into this. Make no promises, tell no lies, aye?
* Internet isn't real good for me where I'm at now, it'll be a few months before that might change for the long run.

I am running this desktop fully at the moment, so I *am* testing it through use, but it also means I might not catch corner-case features that I don't know about.
This project is for me after all, I only feel motivated about what's important to me.

***

*2018-03-25.1* - Redid a lot of my build script to work correctly.
Opted to force `LIB_INSTALL_DIR` and `PREFIX` on all similar Deepin packages, even if they don't *strictly* need it.
Having done that has fixed an issue with the dock not finding a file for the power menu.

***

*2018-03-24.2* - Got my build script set up, should now help insulate me from accidentally inheriting deps that are not in my lists.
Will in due course rebuild all packages to validate my run/build_dep files.
For now though, I've updated everything!

***

*2018-03-24.1* - Gone back through all my packages, spent way too long fighting `treefrog-framework`, but have no un-commited files or changes now.
Will start upgrading more things in the morning...  
Some things of note:
* If I don't include a rundep that the arch repos do, it's because I can't see why I need it. I will slowly try to add these back in as I determine why I need them
* All things considered, the desktop is running really well. Niggling issues include:
  * ~~~Dock power menu does not work, can't see why (that is, the error message says it can't find a file that I think exists)~~~
  * Dock/Launcher/Control Center are sporadic about HiDPI support when launched by startdde (that is, at login). If manually launched from the terminal, they're fine. Need to investigate what flags might cause that.

***

*2018-03-23.1* - Still more combing through.
Trying to make sure `startdde` has all the correct deps to run the DE.
Mostly working?
Running under a VM to test stock has issues since window manager stuff gets knocked about for the sake of performance (and perhaps rightly so, but still).

***

*2018-03-22.1* - Combing back through with a locked set of packages (there are some updates floating out there - I'm leaving them until I rebuild the whole stack).
Have pretty much made sure the current (normally working, i.e - not the image viewer) desktop apps have all the correct deps to run solo.

***

*2018-03-21.2* - So, yeah, I got the critical bits in to make things run now.
[M'pics](https://imgur.com/a/LoZGW).
Key bit was `deepin-qt5dxcb-plugin` to tie things together.
Confusing name meant I kept overlooking it for a long time.

***

*2018-03-21.1* - I've been working through, trying to get a functioning desktop.
Takes a while though...

***

*2018-03-10.1* - I've sorta gotten past the point of needing to watch the Arch repos, so maybe I'll do more here?
Thinking I'll be ironing things out, package by package (i.e. Terminal and all deps, file manager and all deps, etc.)
Ideally, I will keep rundeps to a minumum, since someone might only want one app.

***

*2018-03-05.1* - I poked some more, got past some issues, still stuck on some things.

***

*2018-03-01.1* - I tried poking at this some more, but Arch is lagging upstream and I can't be bothered to work on this too much. The effort of attempting to build *and update* and desktop stack at the same time is beyond me.
Maybe someday...
