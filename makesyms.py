import os

home = os.path.expanduser("~")
path = os.path.join(home, '.dotfiles')

home_links = [
    ('vim', '.vimrc'),
    ('tmux', '.tmux.conf'),
    ('tig', '.tigrc'),
    ('zsh', '.zshrc'),
    ('X', '.Xmodmap'),
]


def get_paths(link):
    filename = link[1]
    link_target_path = os.path.join(home, filename)
    link_origin_path = os.path.join(path, os.path.join(*link))
    return filename, link_target_path, link_origin_path


def backup_existing_configs(link):
    fn, tp, op = get_paths(link)
    back_up_folder = os.path.join(path, '.backup')
    if os.path.exists(tp):
        if not os.path.exists(back_up_folder):
            print "Creating backup folder..."
            os.mkdir(back_up_folder)
        if os.path.islink(tp) and os.path.realpath(tp) == op:
            return
        print "Backing up '%s' ..." % tp
        os.rename(tp, os.path.join(back_up_folder, fn))


def make_link(link):
    fn, tp, op = get_paths(link)
    if not os.path.exists(tp):
        print "Creating symlink for '%s'..." % fn
        os.symlink(op, tp)


def do_files():
    for link in home_links:
        backup_existing_configs(link)
        make_link(link)


if __name__ == "__main__":
    do_files()
