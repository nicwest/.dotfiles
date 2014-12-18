import os

home = os.path.expanduser("~")
path = os.path.join(home, '.dotfiles')

links = [
    ('~', 'vim', '.vimrc'),
    ('~', 'tmux', '.tmux.conf'),
    ('~', 'tig', '.tigrc'),
    ('~', 'zsh', '.zshrc'),
    ('~', 'X', '.Xmodmap'),
    ('~', 'mutt', '.muttrc'),
    ('~/.config', 'flake8', 'flake8')]


def get_paths(link):
    filename = link[2]
    directory = os.path.expanduser(link[0])
    link_target_path = os.path.join(directory, filename)
    link_origin_path = os.path.join(path, os.path.join(*link[1:]))
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
    for link in links:
        backup_existing_configs(link)
        make_link(link)


if __name__ == "__main__":
    do_files()
