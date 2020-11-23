#!/usr/bin/env bash

stowdir="${FP}/.local/stow"
pkgdir="${FP}/.local/stow/${pkgname}"
patchelf="${FP}/.local/bin/patchelf"
stow="${FP}/.local/bin/stow"
strip=${strip:-1}

do_purge() {
  cd "${pkgdir}"
  rm -f ".crates2.json"
  rm -f ".crates.toml"
  rm -f "share/info/dir"
}

do_strip() {
  strip_binaries="--strip-all"
  strip_shared="--strip-unneeded"
  strip_static="--strip-debug"
  do_patchelf="0"

  cd "${pkgdir}"
  local binary strip_flags
  find . -type f -perm -u+w -print0 2>/dev/null | while IFS= read -rd '' binary ; do
    case "$(file --mime --brief "${binary}")" in
      *application/x-sharedlib*)  # Libraries (.so)
        strip_flags="${strip_shared}"
        do_patchelf="1"
        ;;
      *application/x-archive*)    # Libraries (.a)
        strip_flags="${strip_static}";;
      *application/x-object*)
        case "${binary}" in
          *.ko)                   # Kernel module
            strip_flags="${strip_shared}";;
          *)
            continue;;
        esac;;
      *application/x-executable*) # Binaries
        strip_flags="${strip_binaries}"
        do_patchelf="1"
        ;;
      *application/x-pie-executable*)  # Relocatable binaries
        strip_flags="${strip_shared}"
        do_patchelf="1"
        ;;
      *)
        continue ;;
    esac
    if [[ "${strip}" == "1" ]]; then
      strip "${binary}" ${strip_flags}
    fi
    if [[ "${do_patchelf}" == "1" ]]; then
      "${patchelf}" --set-rpath "${HOME}/Workspace/.local/lib" "${binary}"
    fi
    set +o errexit
    shift
    set -o errexit
  done
}

do_stow() {
  cd "${stowdir}"
  "${stow}" -v "${pkgname}"
}

do_everything() {
  do_install
  do_purge
  do_strip
  do_stow
}
