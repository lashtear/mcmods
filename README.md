# lashtear's modpack infrastructure

This is a mostly as-is dump of the infrastructure for prior Mechanipus modpacks for minecraft.

I tend to use Technic as the launcher, with support for the Solder system for distributing individual mods so that updates are dramatically smaller.

In practice, this repo sits locally on a dev machine;

   * `mods-as-distributed` holds copies of the upstream jars/zips/etc
   * `solder-packs/*.sh` are scripts for building individual packs; some are very old and no doubt quite hilariously broken.
   * `solder-packs/pkg-mod-lib.sh` is not a modpack, but more of a set of common functions.  A lot of refactoring should be done.

Upstream Solder was not designed for developers or CI-aware people in any form; I think they honestly expect you to spend decades clicking around in their hideous PHP interface.  No idea why anyone thinks that is remotely usable.

Instead, each script here like `mmt5.sh` will grab, compress, normalize and upload each jar to the solder instance with all of the appropriate metadata (Authors, URL of record, etc.).  Not only does this help meet licensing obligations, but it helps in tracking down updates and other features.  That metadata (and indeed all communication with the server-side of solder) is handled by the script generating a `.sql` file, `rsync`ing it over with the mods, and applying it.

Yes, this is hideous.

Things like configurations, locally-controlled resource packs, etc, can be constructed from git repos.  In some cases, mods can be built from source, but this is less common given how slow Java is.

Prior versions used git-annex to store mods in `mods/`, but I've removed most of that content as it isn't terribly relevant.  The original history started in 2014ish, and did not include the first TFC map; that predated my use of Solder.
