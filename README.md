# zsh

Personal zsh setup for a consistent shell environment across machines.

## Features

- zsh setup with a preconfigured prompt
- shell aliases and helper functions
- managed command-line tools
- bundled terminal font support
- machine-specific local configuration
- update helper for the shell environment and installed tools

## Setup

Clone this repository into your home directory:

```bash
cd ~
git clone https://github.com/ToBoNaToR3/zsh
cd zsh
```

Run the install script:

```bash
bash install.sh
```

The installer sets up the shell environment, links the repository configuration
into the expected user locations, installs bundled fonts, and prepares the
managed tool environment.

After installation, restart your terminal or log out and back in if the default
shell was changed.

## Prompt configuration

The prompt is configured with Powerlevel10k.

To adjust the prompt interactively, run:

```bash
p10k configure
```

Use a terminal font with Powerline/Nerd Font glyph support for the best prompt
display. The bundled fonts are installed during setup.

## Usage

Open a new terminal session to load the configuration.

User-specific settings should be added to the machine-specific configuration
file in your home directory. This keeps local preferences separate from the
shared repository configuration.

Use the provided update helper from an interactive shell session to refresh the
repository, shell framework, plugins, and managed tools.

To remove installed files while keeping the repository, fonts, history, mise, and
machine-specific config, run:

```bash
bash uninstall.sh
```

Shell configuration lives in `config/zsh`, and the interactive shell toolset is
managed by `config/mise/mise.toml`. CI-only tools and lint tasks live in
`.config/mise`.

## Development

A container setup is available for testing the installation in a clean
environment.

Build the Docker image from the repository root:

```bash
docker build -t zsh-test .
```

Run the image interactively:

```bash
docker run -it zsh-test
```
