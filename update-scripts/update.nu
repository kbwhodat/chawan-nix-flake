export def update_lock []: nothing -> nothing {
  let run_update = (nix flake update --update-input nixpkgs | complete)
  if $run_update.exit_code != 0 {
    error make { msg: "Failed to update nixpkgs input" }
  }
}
