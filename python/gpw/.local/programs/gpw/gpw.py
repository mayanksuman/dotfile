#!/usr/bin/python3

import os
import sys
from functools import partial
from collections import namedtuple
import configparser
import re
import base64
import hashlib
import time
from getpass import getpass


import local_module.pyperclip as pyperclip

# GPW_DATA_LOCATION = os.path.abspath("~/.local/share/gpw")
GPW_CONFIG_DIR = os.path.expanduser("~/.config/gpw")

CFG_FILE = os.path.join(GPW_CONFIG_DIR, "gpw_conf.secret")

# These file location are overridden by configuration in CFG_FILE
SALT_FILE = os.path.join(GPW_CONFIG_DIR, 'gpw_salt.secret')
SITE_INFO_FILE = os.path.join(GPW_CONFIG_DIR, 'gpw_site.secret')

VALID_HASH_ALGO = {name: getattr(hashlib, name)
                   for name in hashlib.algorithms_guaranteed}


def check_clipboard(clipboard_name):
    if not (clipboard_name in
            {"primary", "secondary", "stdout"}):
        print_err(f'{clipboard_name} is not a valid clipboard.')
        return False
    return True


def check_hash_algo(algo_name):
    if algo_name not in VALID_HASH_ALGO.keys():
        print_error('Invalid hash algorithm: {algo_name}.'
                    'Check configuration.')
    return True


def add_required_msg(data, required_msg):
    _req_msg = ''
    for ch in required_msg:
        if re.search(ch, data) is None:
            _req_msg += ch

    return data[:-len(_req_msg)] + _req_msg


def _bxor(s1, s2):
    result = bytes((s1[i % len(s1)] ^ s2[i % len(s2)]
                    for i in range(max(len(s1), len(s2)))))
    return result


def gen_passwd(secret_msg, site_config):
    """Generate random string unique for data provided."""
    salt_file = os.path.abspath(os.path.expanduser(site_config['SALT_FILE']))
    if os.path.isfile(salt_file):
        try:
            with open(salt_file, mode='rb') as file:
                salt = file.read()
        except IOError:
            print_error(f'Reading salt file ({salt_file}) failed.')
    else:
        print_error(f'Salt file ({salt_file}) do not exist.')

    _username = (f"{site_config['USERNAME_PREFIX']}{site_config['USERNAME']}"
                 f"{site_config['USERNAME_SUFFIX']}")
    _site_name = (f"{site_config['SITENAME_PREFIX']}{site_config['SITENAME']}"
                  f"{site_config['SITENAME_SUFFIX']}")

    data = f"{secret_msg}{_username}{_site_name}{salt}"
    rand_data = [_username,
                 _site_name,
                 secret_msg,
                 _bxor(bytes(_username, 'ascii'), bytes(secret_msg, 'ascii')),
                 _bxor(bytes(_site_name, 'ascii'), bytes(secret_msg, 'ascii')),
                 ]
    lr = len(rand_data)

    for i in range(int(site_config['ITERATIONS'])):
        data = "{}{}{}".format(data, rand_data[i % lr], salt).encode('utf-8')
        data = VALID_HASH_ALGO[site_config['HASH_ALGORITHM']](data).hexdigest()

    data = base64.b85encode(bytes(data, 'ascii'), pad=True).decode('utf-8')

    # Filter allowed characters from data and required_msg
    data = re.sub('[^' + site_config['ALLOWED_CHARACTERS'] + ']', '', data)
    reg_msg = re.sub('[^' + site_config['ALLOWED_CHARACTERS'] + ']',
                     '', site_config['REQUIRED_MSG'])

    passwd_length = int(site_config['LENGTH'])
    if len(data) >= passwd_length:
        data = data[:passwd_length]

    # Add required characters
    passwd = add_required_msg(data, reg_msg)

    return passwd.strip()


def copy_to_clipboard(data, clipboard_name, wait_seconds):
    check_clipboard(clipboard_name)

    if clipboard_name.lower().strip() != 'stdout':
        init_clipboard_function(clipboard_name)
        _to_clipboard(data)
        print_info(f'The output is available for {wait_seconds} seconds'
                   ' (or till clipboard changes).')
        try:
            pyperclip.waitForNewPaste(timeout=wait_seconds)
        except pyperclip.PyperclipTimeoutException:
            pass
        # time.sleep(wait_seconds)
        curr_clipboard_content = _from_clipboard()
        if (curr_clipboard_content == data):
            _clear_clipboard()
    else:
        print_no_style(data)


def init_clipboard_function(clipboard_name):
    global copy_func, paste_func
    copy_func, paste_func = None, None

    primary_clipboard_supported = True
    if pyperclip.executable_exists('xsel'):
        pyperclip.set_clipboard('xsel')
    elif pyperclip.executable_exists('xclip'):
        pyperclip.set_clipboard('xclip')
    else:
        pyperclip.determine_clipboard()
        primary_clipboard_supported = False

    if clipboard_name.lower().strip() == 'primary':
        if primary_clipboard_supported:
            pyperclip.copy = partial(pyperclip.copy, primary=True)
            pyperclip.paste = partial(pyperclip.paste, primary=True)
        else:
            if sys.platform.startswith('linux'):
                print_info('Please install xsel or xclip '
                           'for primary clipboard.')
                print_info('Using secondary clipboard.')
            clipboard_name = 'secondary'

    if clipboard_name.lower().strip() == 'secondary':
        # Nothing to do here as secondary is default in pyperclip
        pass


def _from_clipboard():
    return pyperclip.paste()


def _to_clipboard(data):
    return pyperclip.copy(data)


def _clear_clipboard():
    return pyperclip.copy('')


def gen_salt_file(filepath, length):
    filepath = os.path.abspath(filepath)
    if os.path.isfile(filepath):
        print_warn(f'The file {filepath} exist.'
                   'Please make a backup as the file will be overwritten.')
        input('Press any key to continue ...')
    with open(filepath, mode='wb') as f:
        f.write(os.urandom(length))


def set_default_config():
    if (sys.platform.startswith('linux') and
            (pyperclip.executable_exists('xsel') or
             pyperclip.executable_exists('xclip'))):
        _clipboard_name = "primary"
    else:
        _clipboard_name = "secondary"

    default_config = dict(
        # Random Data
        USERNAME={'_default_': "username"},
        USERNAME_PREFIX={'_default_': "prefix_username"},
        USERNAME_SUFFIX={'_default_': "username_suffix"},

        SITENAME_PREFIX={'_default_': "prefix_website"},
        SITENAME_SUFFIX={'_default_': "website_suffix"},
        ALLOWED_CHARACTERS={'_default_':
                            'a-zA-Z0-9 !-/:-@[-_{-~'},  # ascii code 32-126

        REQUIRED_MSG={'_default_': "Aa@1"},
        LENGTH={'_default_': 24},
        SALT_FILE={'_default_': SALT_FILE},

        # Configuration Option
        ITERATIONS={'_default_': 10000},
        WAIT_SECONDS={'_default_': 10},
        HASH_ALGORITHM={'_default_': 'sha3_512'},

        # Program wide settings
        MISC=dict(clipboard_name=_clipboard_name,
                  save_site_info=1,
                  site_info_file=SITE_INFO_FILE),
    )

    # Setting up default files if they are missing:
    if not os.path.isdir(GPW_CONFIG_DIR):
        os.makedirs(GPW_CONFIG_DIR, exist_ok=True)

    if not os.path.isfile(CFG_FILE):
        print_warn('Default configuration file missing.'
                   f'Creating {CFG_FILE} ...')
        _config_parser = configparser.ConfigParser()
        _config_parser.read_dict(default_config)
        with open(CFG_FILE, mode='w') as file:
            _config_parser.write(file)

    if not os.path.isfile(SALT_FILE):
        print_warn('Default salt file missing.'
                   f'Creating {SALT_FILE} ...')
        gen_salt_file(SALT_FILE, 4096)

    if not os.path.isfile(SITE_INFO_FILE):
        print_warn('Default site info file missing.'
                   f'Creating {SITE_INFO_FILE} ...')
        with open(SITE_INFO_FILE, mode='w') as f:
            pass

    return default_config


def read_config(site_name):
    default_config = set_default_config()
    _config_parser = configparser.ConfigParser()
    _config_parser.read(CFG_FILE)
    user_config = {s: dict(_config_parser.items(s))
                   for s in _config_parser.sections()}

    # Sanity check on user_config: Randomized parts should have _default_ key.
    for key, val in user_config.items():
        if key not in default_config.keys():
            print_error(f'Invalid configuration section "{key}" found.'
                        'Clean the configuration file. Exitting')
    for key, val in user_config.items():
        if key != 'MISC':
            if '_default_' not in val.keys() or val['_default_'] is None:
                print_warn(
                    f'Default value (_default_) not set for section {key}.'
                    'For better security define the default value.'
                    'Currently using default value from program.'
                )
                user_config[key]['_default_'] = default_config[key][
                    '_default_']

    site_config = dict()
    site_config.update({k.upper(): v for k, v in user_config['MISC'].items()})
    for key, val in user_config.items():
        if key != 'MISC':
            if site_name in val.keys():
                site_config[key] = user_config[key][site_name]
            else:
                site_config[key] = user_config[key]['_default_']

    check_clipboard(site_config['CLIPBOARD_NAME'])
    check_hash_algo(site_config['HASH_ALGORITHM'])

    site_config['SITENAME'] = site_name
    return site_config


def init_colorama():
    global foreground, background, style
    try:
        import colorama
        from colorama import Fore, Back, Style
        colorama.init()
        foreground, background, style = Fore, Back, Style
        return True
    except ImportError:
        foreground, background, style = setup_no_colorama()
        return False


def setup_no_colorama():
    col_fields = ['BLACK',
                  'BLUE',
                  'CYAN',
                  'GREEN',
                  'LIGHTBLACK_EX',
                  'LIGHTBLUE_EX',
                  'LIGHTCYAN_EX',
                  'LIGHTGREEN_EX',
                  'LIGHTMAGENTA_EX',
                  'LIGHTRED_EX',
                  'LIGHTWHITE_EX',
                  'LIGHTYELLOW_EX',
                  'MAGENTA',
                  'RED',
                  'RESET',
                  'WHITE',
                  'YELLOW',
                  ]
    style_fields = ['BRIGHT',
                    'DIM',
                    'NORMAL',
                    'RESET_ALL',
                    ]
    _col = namedtuple('_col', col_fields, defaults=('') * len(col_fields))
    _sty = namedtuple('_sty', style_fields, defaults=('') * len(style_fields))
    _foreground, _background, _style = _col(), _col(), _sty()

    return _foreground, _background, _style


def deinit_colorama():
    try:
        import colorama
        colorama.deinit()
    except ImportError:
        pass


def print_default_style(*args, **kwargs):
    print(*args, **kwargs)


def print_info(*args, **kwargs):
    print(foreground.GREEN + args[0], *args[1:], style.RESET_ALL, **kwargs)


def print_warn(*args, **kwargs):
    print(foreground.YELLOW + 'WARN: ' + args[0], style.RESET_ALL, *args[1:],
          **kwargs)


def print_error(*args, **kwargs):
    print(foreground.RED + 'ERROR: ' + args[0], *args[1:],
          style.RESET_ALL, **kwargs)
    deinit_colorama()
    sys.exit(1)


def main():
    is_colorama_present = init_colorama()
    site_name = getpass('Site Name: ')
    config = read_config(site_name)
    site_info_file = config['SITE_INFO_FILE']
    with open(site_info_file, mode='r') as file:
        sites_used = file.read().split()
    sec_msg = getpass('Secret Sause (Message): ')
    if site_name in sites_used:
        print_info(f'This package has been used for this site before.')
    passwd = gen_passwd(secret_msg=sec_msg, site_config=config)
    copy_to_clipboard(passwd,
                      config['CLIPBOARD_NAME'],
                      int(config['WAIT_SECONDS']))
    if int(config['SAVE_SITE_INFO']):
        if site_name not in sites_used:
            with open(site_info_file, mode='a+') as file:
                file.write(f'{site_name}\n')
    print_info('Bye.')
    deinit_colorama()


if __name__ == '__main__':
    main()
