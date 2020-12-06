#!/usr/bin/env bash

srcdir="${FP}/src/${pkgname}"
builddir="${FP}/build/${pkgname}"
stowdir="${FP}/.local/stow"
pkgdir="${FP}/.local/stow/${pkgname}"
proto="${source%%://*}"
proto="${proto%%+*}"
filename="${filename:-${source}}"
filename="${filename##*/}"
extension="${filename##*.}"
patchelf="${FP}/.local/bin/patchelf"
stow="${FP}/.local/bin/stow"
strip_components=${strip_components:-1}
do_builddir=${do_builddir:-1}
do_patchelf=${do_patchelf:-1}
do_strip=${do_strip:-1}
do_stow=${do_stow:-1}

do_download() {
  case "${proto}" in
    http | https)
      mkdir -p "${FP}/tarballs"
      if [[ ! -f "${FP}/tarballs/${filename}" ]]; then
        curl -L "${source}" -o "${FP}/tarballs/${filename}"
      fi
    ;;
    git)
      if [[ ! -d "${srcdir}" ]]; then
        git clone --recursive --depth=1 "${source##${proto}+}" "${srcdir}"
      else
        cd "${srcdir}"
        git fetch
      fi
    ;;
  *)
    echo "Invalid source protocol"
    exit 1
    ;;
  esac
}

do_unpack() {
  if [[ "${do_builddir}" == "1" ]]; then
    mkdir -p "${builddir}"
  fi
  mkdir -p "${srcdir}"

  if [[ "${proto}" = "git" ]]; then
    return
  fi

  if [[ "${extension}" == "zip" ]]; then
    temp=$(mktemp -d)
    unzip "${FP}/tarballs/${filename}" -d "${temp}"
    mv "${temp}"/*/* "${srcdir}"
    rm -rf "${temp}"
  else
    tar xf "${FP}/tarballs/${filename}" --strip-components=${strip_components} -C "${srcdir}"
  fi
}

do_purge() {
  cd "${pkgdir}"
  rm -f "share/info/dir"
  find . ! -type d -name "*.la" -exec rm -f -- '{}' +
}

do_strip() {
  strip_binaries="--strip-all"
  strip_shared="--strip-unneeded"
  strip_static="--strip-debug"

  cd "${pkgdir}"
  local binary strip_flags
  find . -type f -perm -u+w -print0 2>/dev/null | while IFS= read -rd '' binary ; do
    do_strip_local="0"
    do_patchelf_local="0"
    case "$(file --mime --brief "${binary}")" in
      *application/x-sharedlib*)  # Libraries (.so)
        strip_flags="${strip_shared}"
        do_strip_local="1"
        do_patchelf_local="1"
        ;;
      *application/x-archive*)    # Libraries (.a)
        strip_flags="${strip_static}"
        do_strip_local="1"
        ;;
      *application/x-object*)
        case "${binary}" in
          *.ko)                   # Kernel module
            strip_flags="${strip_shared}"
            do_strip_local="1"
            ;;
          *)
            continue
            ;;
        esac
        ;;
      *application/x-executable*) # Binaries
        strip_flags="${strip_binaries}"
        do_strip_local="1"
        do_patchelf_local="1"
        ;;
      *application/x-pie-executable*)  # Relocatable binaries
        strip_flags="${strip_shared}"
        do_strip_local="1"
        do_patchelf_local="1"
        ;;
      *)
        continue ;;
    esac
    if [[ "${do_strip}" == "1" && "${do_strip_local}" == "1" ]]; then
      strip "${binary}" ${strip_flags}
    fi
    if [[ "${do_patchelf}" == "1" && "${do_patchelf_local}" == "1" ]]; then
      "${patchelf}" --set-rpath "${HOME}/Workspace/.local/lib" "${binary}"
    fi
    set +o errexit
    shift
    set -o errexit
  done
}

do_stow() {
  if [[ "${do_stow}" == "1" ]]; then
    cd "${stowdir}"
    "${stow}" -v "${pkgname}"
  fi
}

do_everything() {
  do_download
  do_unpack
  do_configure
  do_compile
  do_install
  do_purge
  do_strip
  do_stow
}
