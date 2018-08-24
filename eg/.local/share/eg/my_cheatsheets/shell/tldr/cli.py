#!/usr/bin/env python
# -*- coding: utf-8 -*-

from __future__ import absolute_import

import os
from os import path
import subprocess
import sys
import pydoc
import pdb

import click
import yaml

from tldr import __version__
from .config import get_config
from .manage_pages import report_all_pages, parse_man_page, find_page_location
from .manage_pages import update_tldr_pages, build_index, list_commands


@click.group(context_settings={'help_option_names': ('-h', '--help')})
@click.version_option(__version__, '-V', '--version', message='%(version)s')
def cli():
    """A python client for tldr: simplified and community-driven man pages."""
    pass  # pragma: no cover


@cli.command()
@click.argument('command')
@click.option('--on', type=click.Choice(['linux', 'osx', 'sunos']),
              help='the specified platform.')
def find(command, on):
    """Find the command usage."""
    output_lines = parse_man_page(command, None, on)
    is_squeeze = get_config()['squeeze']
    try:
        if is_squeeze:
            pydoc.pipepager(''.join(output_lines), cmd='less -RMFXKs')
        else:
            pydoc.pipepager(''.join(output_lines), cmd='less -RMFXK')
    except KeyboardInterrupt:
        pass


@cli.command()
def update():
    """Update to the latest pages."""
    update_tldr_pages()
    click.echo('Update complete')

@cli.command()
def init():
    """Init config file."""
    default_config_path = path.join(
        (os.environ.get('TLDR_CONFIG_DIR') or
         os.environ.get('XDG_CONFIG_HOME') or
         path.join(path.expanduser('~'), '.config')),
        'tldr.py.conf')
    if path.exists(default_config_path):
        click.echo("There is already a config file exists, "
                   "skip initializing it.")
    else:
        repo_path = click.prompt("Input the tldr repo path")
        repo_path = os.path.abspath(os.path.expanduser(repo_path))
        if not path.exists(repo_path):
            sys.exit("Repo path not exist, clone it first.")

        platform = click.prompt("Input your platform(linux, osx or sunos)")
        if platform not in ['linux', 'osx', 'sunos']:
            sys.exit("Platform should be linux, osx or sunos.")

        custom_path = click.prompt("Input directory having custom tldr pages")
        custom_path = os.path.abspath(os.path.expanduser(custom_path))
        if not path.exists(custom_path):
            sys.exit("Custom path not exist.")
        default_data_path = path.join(
            (os.environ.get('XDG_DATA_HOME') or
             path.join(path.expanduser('~'), '.local', 'share')),
            'tldr')

        colors = {
            "headline": "red",
            "description": "blue",
            "usage": "green",
            "command": "cyan",
            "parameter": "white"
        }

        config = {
            "repo_directory": repo_path,
            "custom_pages_directory": custom_path,
            "data_directory": default_data_path,
            "colors": colors,
            "platform": platform,
            "squeeze": 0
        }
        with open(default_config_path, 'w') as f:
            f.write(yaml.safe_dump(config, default_flow_style=False))

        click.echo("Initializing the config file at {0}".format(
            default_config_path))
        update_tldr_pages()


@cli.command()
def reindex():
    """Rebuild the index."""
    build_index()
    click.echo('Rebuild the index.')


@cli.command()
@click.argument('command')
@click.option('--on', type=click.Choice(['linux', 'osx', 'sunos']),
              help='the specified platform.')
def locate(command, on):
    """Locate the command's man page."""
    location, other_pages_location = find_page_location(command, None, on)
    click.echo(*report_all_pages(location, other_pages_location))


@cli.command()
@click.argument('command', required=False)
@click.option('--on', type=click.Choice(['linux', 'osx', 'sunos']),
              help='the specified platform.')
def list(command, on):
    """list the command's man page."""
    command_list = list_commands()
    click.echo(' '.join(command_list))
