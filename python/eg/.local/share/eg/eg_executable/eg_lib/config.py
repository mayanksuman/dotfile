#!/usr/bin/env python
# -*- coding: utf-8 -*-

from __future__ import absolute_import

import io
import os
from os import path
import sys

import yaml


def get_config():
    """Get the configurations from config file and return it as a dict."""
    config_path = path.join(
        (os.environ.get('TLDR_CONFIG_DIR') or
         os.environ.get('XDG_CONFIG_HOME') or
         path.join(path.expanduser('~'), '.config')),
        'eg','eg.conf')
    config_path = os.path.abspath(os.path.expanduser(config_path))
    if not path.exists(config_path):
        init_config(config_path)

    with io.open(config_path, encoding='utf-8') as f:
        try:
            config = yaml.safe_load(f)
        except yaml.scanner.ScannerError:
            sys.exit("The config file is not a valid YAML file.")

    supported_colors = ['black', 'red', 'green', 'yellow', 'blue',
                        'magenta', 'cyan', 'white']
    if not set(config['colors'].values()).issubset(set(supported_colors)):
        sys.exit("Unsupported colors in config file: {0}.".format(
            ', '.join(set(config['colors'].values()) - set(supported_colors))))
    init_data_dirs(config)
    return config


def init_config(init_config_path):
    default_data_path = path.join(
            (os.environ.get('XDG_DATA_HOME') or
             path.join(path.expanduser('~'), '.local', 'share')),
            'eg')
    if not os.path.exists(default_data_path):
        try:
            os.makedirs(default_data_path)
        except IOError:
            pass
    # platfrom selection
    platform = ''
    pager = 'less -RMFXK'
    editor = 'nvim'
    if sys.platform.startswith('linux'):
        platform = 'linux'
    elif sys.platform.startswith('darwin'):
        platform = 'osx'
    elif sys.platform.startswith('sunos'):
        platform = 'sunos'
    elif sys.platform.startswith('win') or sys.platform.startswith('cygwin'):
        platform = 'win'
        pager = ''
        editor = ''
    else:
        sys.exit('{0} platform is not supported.'.format(sys.platform))

    tldr_pages_path = path.join(default_data_path, 'tldr_pages')
    custom_pages_path = path.join(default_data_path, 'my_cheatsheets')
    colors = {
            "headline": "red",
            "description": "white",
            "usage": "white",
            "command": "green",
            "parameter": "cyan"
        }

    config = {
        "data_directory": default_data_path,
        "repo_directory": tldr_pages_path,
        "custom_pages_directory": custom_pages_path,
        "colors": colors,
        "platform": platform,
        "squeeze": 1,
        "pager": pager,
        "editor": editor
    }
    config_dir = path.dirname(init_config_path)
    if not os.path.exists(config_dir):
        try:
            os.makedirs(config_dir)
        except IOError:
            pass
    with open(init_config_path, 'w') as f:
        f.write(yaml.safe_dump(config, default_flow_style=False))

    print("Initializing the config file at {0}".format(
        init_config_path))


def init_data_dirs(config):
    # expand and check different paths
    config['data_directory'] = path.abspath(
        path.expanduser(config['data_directory']))
    if not path.exists(config['data_directory']):
        sys.exit("Can't find the data directory, check the `data directory` "
                 "setting in config file.")
    config['repo_directory'] = path.abspath(
        path.expanduser(config['repo_directory']))
    if not path.exists(config['repo_directory']):
        if config['data_directory'] in config['repo_directory']:
            try:
                os.makedirs(config['repo_directory'])
            except IOError:
                pass
        else:
            sys.exit("Can't find the tldr repo, check the `repo_directory` "
                     "setting in config file.")
    config['custom_pages_directory'] = path.abspath(
        path.expanduser(config['custom_pages_directory']))
    if not path.exists(config['custom_pages_directory']):
        if config['data_directory'] in config['custom_pages_directory']:
            try:
                os.makedirs(config['custom_pages_directory'])
            except IOError:
                pass
        else:
            sys.exit("Can't find the custom pages directory, check the "
                     "`custom_pages_directory` setting in config file.")

