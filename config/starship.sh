# usually I would genConfig this, but Rust executables run much faster
eval "$(starship init bash)"

export STARSHIP_CONFIG="${CONFIG_DIR}/starship/starship.toml"
