# Boxen personal settings for mmickan
class people::mmickan {
  git::config::global { 'user.email':
    value => 'mark.mickan@netspot.com.au',
  }
  git::config::global { 'user.name':
    value => 'Mark Mickan',
  }
  git::config::global { 'color.ui':
    value => 'auto',
  }

  include osx::global::tap_to_click
  include osx::universal_access::enable_scrollwheel_zoom
  include osx::global::natural_mouse_scrolling
  class { 'osx::dock::hot_corners':
    top_left    => 'Start Screen Saver',
    bottom_left => 'Mission Control',
  }
  osx::recovery_message { 'If found, please contact mark.mickan@netspot.com.au, or phone +61 419 805 049': }

  dockutil::item { 'Add Terminal':
    item     => '/Applications/Utilities/Terminal.app',
    label    => 'Terminal',
    action   => 'add',
    position => 2,
  }

  include fish
  file { "/Users/${::boxen_user}/.config":
    target  => "/Users/${::boxen_user}/.dotfiles/.config",
    require => Repository["/Users/${::boxen_user}/.dotfiles"],
  }

  class { 'vim':
    require => Class['python'],
  }
  include python

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

  include wunderlist

  include clipmenu

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

}
