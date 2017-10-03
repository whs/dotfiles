#!/usr/bin/env python3
import os
import sys
import socket
import shutil

print('Dotfiles loaded! Checking for recommended apps...')

if sys.version_info.major < 3 or sys.version_info.minor < 3:
	print('Your Python is not supported! Use at least Python 3.3')
	exit(1)

def app(name, hint=None, condition=True):
	if not condition:
		return None
	return {
		'name': name,
		'hint': hint if hint else 'not found',
	}

is_arch = os.path.isfile('/etc/arch-release')
is_macos = sys.platform == 'darwin'

recommended_apps = [
	# package managers
	app('brew', 'run /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" to install', is_macos),
	app('cargo', 'Install from homebrew/pacman or curl https://sh.rustup.rs -sSf | sh'),
	app('pip'),

	# languages (python3 is implicit)
	app('rustc'),
	app('node'),

	# compiler
	app('cc'),
	app('make'),
	app('git'),

	# network suite
	app('mtr'),
	app('wget'),
	app('curl'),
	app('rsync'),
	app('nmap'),

	# cloud
	app('kubectl', 'https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl-binary-via-curl'),
	app('helm'),
	app('docker'),
	app('aws'),
	app('s3cmd'),
	app('gcloud', 'yaourt -S google-cloud-sdk or in brew cask'),

	# utils
	app('yaourt', '''[archlinuxfr]
Server = http://repo.archlinux.fr/$arch
SigLevel = Optional TrustAll''', is_arch),
	app('parallel', 'cargo install parallel'),
	app('rg', 'cargo install ripgrep'),
	app('code'),
	app('adb'),
	app('mpv'),
	app('ssh-copy-id', 'brew install ssh-copy-id'),
	app('youtube-dl'),
]

for item in recommended_apps:
	if not item:
		continue
	if not shutil.which(item['name']):
		print('\033[0m\033[1m{name}:\033[0m\t\033[36m{hint}'.format(**item))
	else:
		print('\033[0m\033[1m{name}:\033[0m\t\033[92mok'.format(**item))

print('\033[0m')

if 'zsh' not in os.environ['SHELL']:
	print('\033[1m\033[36mSwitch your shell to zsh!\033[0m\n')

print('''Next steps:
1. Copy kubectl
2. Import gpg key
3. Login to aws (~/.aws/credentials), gcloud (gcloud auth login), kubectl
4. If you just installed helm, run helm init -c
5. Install srfrnk.user-extensions for vscode
''')

print('Welcome to \033[93m{}\033[0m'.format(socket.gethostname()))
