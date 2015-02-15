[sbase]: http://tools.suckless.org/sbase
[ubase]: http://tools.suckless.org/ubase
[smdev]: http://git.suckless.org/smdev/
[mksh]: https://www.mirbsd.org/mksh.htm

Prelinux is a set of scripts to build a minimal<sup>1</sup> initrd and
filesystem. It currently builds and installs [sbase][sbase],
[ubase][ubase], [smdev][smdev], [mksh][mksh] and cryptsetup. The
resulting filesystem can be used to build flexible Linux init
configurations.

<sup>1</sup>: prelinux's initrd is 1.4MB (Archlinux uses 8MB). The root
filesystem is 5.5MB with obvious avenues to reduce that number.

How do I use this?
------------------

[musl]: http://www.musl-libc.org/
[arch]: https://www.archlinux.org/

Prelinux is intended to be built in a live Linux environment, before
installing a real OS. It depends on:

- Linux kernel sources, for `gen_init_cpio`
- bash, __specifically bash__, to run the build scripts
- curl, to download source tarballs
- tar, to extract source tarballs
- git, to clone the suckless repositories
- a full autotools toolchain (blame cryptsetup), for doing absolutely
  nothing
- [musl][musl], for building everything
- man-db, to convert the sbase/ubase manpages to text files (a prelinux
  system does not have a manpage viewer so this is helpful)

The method I recommend you use to create an installation with prelinux
is as follows:

- Boot an [Archlinux][arch] live environment. I chose arch because its
  binary repositories save you from having to build musl/git/etc
- Download and build your favourite kernel. You should extract it to
  `/usr/src/linux-XXX` so prelinux can find it later
- `git clone https://github.com/mikejsavage/prelinux`
- Run through the scripts. They are numbered in order, and top level
  scripts like `1-download.sh` will run all the corresponding lower
  level scripts
- Before you run `4-1-fs-initrd.sh`, you will want to edit `init` in the
  repository root. This file gets inserted into the initrd as
  `/init`. See below for inspiration!
- If you're using the real filesystem, you might also want to create
  `prelinux/sbin/init`
- Write the prelinux files to disk. `initrd-XXX` goes in `/boot` with
  your kernel, `prelinux` can be written to its own partition
- Install Linux, not necessarily Arch, and __make sure you don't let the
  installer nuke__ `/boot`


Using prelinux for authenticated disk encryption
------------------------------------------------

[TPM]: http://en.wikipedia.org/wiki/Trusted_Platform_Module

Full disk encryption (FDE) is not quite what it says on the tin. Your
`/boot` partition, and therefore your kernel, and your MBR are left as
plaintext. Typical cryptsetup configurations take no steps to remedy
this, opening a potential avenue for attack. 

One possible solution to the problem is to check the squishy parts of
your OS have not been tampered with. Closed vendors have taken to using
[Trusted Platform Module][TPM] to ensure untrusted kernels do not get
executed, but that was Not Invented Here.

Prelinux allows you to create a multi-stage boot that checks itself for
fiddling before decrypting anything that matters. For an example of such
a boot process, first let's say your disk is laid out like this:

0. Your plaintext MBR
1. `/boot`, which holds your plaintext kernel and a plaintext
   prelinux initrd
2. An encrypted prelinux partition
3. Your real operating system and data

And then the boot process looks like:

- The MBR loads the kernel which loads the initrd, all plaintext
- The kernel executes `/init` in the initrd, which is a script that
  prompts you for the password to decrypt the prelinux partition, and
  then switch_roots into it
- The switch_root launches `/sbin/init`, which computes checksums of the
  MBR and `/boot` and compares them with values stored in the encrypted
  partition
- If they match up, the user is prompted for another password to decrypt
  their real operating system and data. Prelinux can clean up after
  itself and pivot_root into the real OS, then booting continues as
  normal

### Weaknesses

There are some flaws with the above boot process.

Firstly, confidentiality is not integrity. LUKS partitions do not
perform integrity checks, therefore an attacker can blindly flip bits
without cryptsetup noticing. I believe it's safe to ignore this attack,
as it would be unlikely for an attacker to blindly update the encrypted
checksums to be anything usable.

Secondly, how do you __know__ that your code was running? An attacker
who is able to observe your boot process may be able to mimic it. A
malicious initrd could `dd` to create fake disk activity, tell the user
everything is wonderful, and then steal their encryption key. A possible
workaround for this is to store two pieces of information on the
prelinux partition:

- a counter which is incremented on every boot
- a secret which is used to create one-time MACs of the counter,
  __after__ the incremented counter has been synced to disk (this is
  required so MACs don't get repeated if you pull the plug)

You can then keep the secret on another device (such as your phone) and
the last value of the counter you saw. This gives you something
approximating two-factor authentication of your boot process. You need
to check two things:

- the MAC computed by prelinux is valid
- counter values aren't being reused - someone could have been looking
  over your shoulder!


Other applications
------------------

[kali]: https://www.kali.org/how-to/emergency-self-destruction-luks-kali/

- [self destruct passwords][kali]. Using prelinux is arguably more
  blatant than Kali because shell scripts are easier to read than
  machine code. It is also arguably less blatant than Kali because you
  aren't running Kali Linux


Build errors
------------

If you try to build prelinux on a glibc system, you need to symlink some
kernel headers where musl can see them. Something like:

	ln -s /usr/include/mtd /path/to/musl/include
