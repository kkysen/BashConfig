export XDG_HOME="${BASH_HOME}"

export XDG_CONFIG_HOME="${CONFIG_DIR}"
export XDG_CACHE_HOME="${CACHE_DIR}"
export XDG_DATA_HOME="${DATA_DIR}"

# load these as defaults
. "${XDG_CONFIG_HOME}/user-dirs.dirs"

export XDG_DESKTOP_DIR="${DESKTOP}"
export XDG_DOCUMENTS_DIR="${DOCUMENTS}"
export XDG_DOWNLOAD_DIR="${DOWNLOADS}"
export XDG_MUSIC_DIR="${ONE_MUSIC}"
export XDG_VIDEOS_DIR="${ONE_VIDEO}"
export XDG_PICTURES_DIR="${ONE_PHOTOS}"

saveXdgUserDirs
