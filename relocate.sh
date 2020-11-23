#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

FP="${HOME}/Workspace"
bindir="${FP}/local/bin"
libdir="${FP}/local/lib"
libexecdir="${FP}/local/libexec"
patchelf="${bindir}/patchelf"

for dir in "${bindir}" "${libdir}" "${libexecdir}"; do
  cd "${dir}"
  find . -type l -perm -u+w -print0 2>/dev/null | while IFS= read -rd '' binary ; do
    if [[ "${binary}" == "./patchelf" ]]; then
      continue
    fi
    case "$(file --dereference --mime --brief "${binary}")" in
      *application/x-sharedlib*)  # Libraries (.so)
        "${patchelf}" --set-rpath "${HOME}/Workspace/.local/lib" "${binary}" || :
        ;;
      *application/x-executable*) # Binaries
        "${patchelf}" --set-rpath "${HOME}/Workspace/.local/lib" "${binary}" || :
        ;;
      *application/x-pie-executable*)  # Relocatable binaries
        "${patchelf}" --set-rpath "${HOME}/Workspace/.local/lib" "${binary}" || :
        ;;
      *)
        continue ;;
    esac
    set +o errexit
    shift
    set -o errexit
  done
done
