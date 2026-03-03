#!/usr/bin/env -S nix shell nixpkgs#nushell --command nu

use update.nu

def commit_update []: nothing -> nothing {
  update update_lock

  git add -A
  let commit = (git commit -m "auto-update: bump nixpkgs unstable lock" | complete)

  if ($commit.exit_code == 1) {
    print "No updates found in nixpkgs lock"
  } else if ($commit.exit_code == 0) {
    print "Updated flake.lock and committed"
  } else {
    error make { msg: "git commit failed" }
  }
}

commit_update
