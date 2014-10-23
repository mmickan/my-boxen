# Boxen personal settings for mmickan
class people::mmickan {

  # Global git settings
  git::config::global { 'user.email':
    value => 'mark.mickan@netspot.com.au',
  }
  git::config::global { 'user.name':
    value => 'Mark Mickan',
  }
  git::config::global { 'color.ui':
    value => 'auto',
  }

  # My github repositories
  repository { "/Users/${::boxen_user}/src/github.com/mmickan/packer-templates":
    source   => 'https://github.com/mmickan/packer-templates',
    provider => 'git',
  }
  repository { "/Users/${::boxen_user}/src/github.com/mmickan/packer":
    source   => 'https://github.com/mmickan/packer',
    provider => 'git',
  }
  repository { "/Users/${::boxen_user}/src/github.com/mmickan/hiera-consul":
    source   => 'https://github.com/mmickan/hiera-consul',
    provider => 'git',
  }
  repository { "/Users/${::boxen_user}/src/github.com/mmickan/chgo":
    source   => 'https://github.com/mmickan/chgo',
    provider => 'git',
  }

  # General personalisations
  include osx::global::tap_to_click
  include osx::universal_access::enable_scrollwheel_zoom
  include osx::global::natural_mouse_scrolling
  class { 'osx::dock::hot_corners':
    top_left    => 'Start Screen Saver',
    bottom_left => 'Mission Control',
  }
  osx::recovery_message { 'If found, please contact mark.mickan@netspot.com.au, or phone +61 419 805 049': }

  # Terminal.app
  dockutil::item { 'Add Terminal':
    item     => '/Applications/Utilities/Terminal.app',
    label    => 'Terminal',
    action   => 'add',
    position => 2,
  }
  boxen::osx_defaults { 'Pro default Terminal theme':
    user   => $::boxen_user,
    domain => 'com.apple.terminal',
    key    => 'Default Window Settings',
    value  => 'Pro',
    type   => 'string',
  }
  boxen::osx_defaults { 'Pro startup Terminal theme':
    user   => $::boxen_user,
    domain => 'com.apple.terminal',
    key    => 'Startup Window Settings',
    value  => 'Pro',
    type   => 'string',
  }

  # fish shell
  include fish
  file { "/Users/${::boxen_user}/.config":
    target  => "/Users/${::boxen_user}/.dotfiles/.config",
    require => Repository["/Users/${::boxen_user}/.dotfiles"],
  }

  # ssh config
  file { "/Users/${::boxen_user}/.ssh/config":
    target  => "/Users/${::boxen_user}/.dotfiles/.ssh/config",
    require => Repository["/Users/${::boxen_user}/.dotfiles"],
  }

  # vim editor
  include python
  class { 'vim':
    require => Class['python'],
  }
  vim::bundle { [
    'scrooloose/nerdtree',
    'plasticboy/vim-markdown',
    'tpope/vim-fugitive',
    'scrooloose/syntastic',
    'sirver/ultisnips',
    'd11wtq/tomorrow-theme-vim',
    'rodjek/vim-puppet',
    'godlygeek/tabular',
  ]: }
  file { $vim::vimrc:
    target  => "/Users/${::boxen_user}/.dotfiles/.vimrc",
    require => Repository["/Users/${::boxen_user}/.dotfiles"],
  }

  # productivity tools
  include wunderlist
  include clipmenu
  include mosh
  class { 'controlplane':
    version => '1.5.4',
  }
  include spectacle

}
