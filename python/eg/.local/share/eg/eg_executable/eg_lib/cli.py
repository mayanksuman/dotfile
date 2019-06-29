#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from __future__ import absolute_import

import os
from os import path
import subprocess
import sys
import pydoc
from argparse import ArgumentParser

import click
import yaml
import colorama

from .config import get_config
from .manage_pages import report_all_pages, parse_man_page, find_page_location
from .manage_pages import update_tldr_pages, build_index, list_commands
from .manage_pages import edit_custom_page


def main():
    default_tldr_remote = "https://tldr-pages.github.io/assets/tldr.zip"

    parser = ArgumentParser(description="Python command line client for tldr")

    parser.add_argument('-o', '--os',
                        nargs=1,
                        default=None,
                        type=str,
                        choices=['linux', 'osx', 'sunos', 'windows'],
                        help="Override the operating system [linux, osx, sunos, windows]")

    parser.add_argument('-p', '--language',
                        nargs=1,
                        default=None,
                        type=str,
                        help="Programming Language for the command")

    parser.add_argument('-c', '--color',
                        default=None,
                        action='store_const',
                        const=False,
                        help="Override color stripping")

    parser.add_argument('-s', '--tldr_source',
                        nargs=1,
                        default=default_tldr_remote,
                        type=str,
                        help="Override the default tldr page source")

    parser.add_argument('--use-color',
                        action='store_false',
                        default=True,
                        help='Do not colorize output.')

    parser.add_argument('-r', '--reindex',
                        action='store_true',
                        help="Override color stripping")

    parser.add_argument('-u', '--update_tldr',
                        action='store_true',
                        help="Update the tldr pages from tldr site")

    parser.add_argument('-l', '--list',
                        action='store_true',
                        help="List all the commands available")

    parser.add_argument('-f', '--find',
                        action='store_true',
                        help="Find pages for the command")

    parser.add_argument('-e', '--edit',
                        action='store_true',
                        help="""Edit local markdown files. If editor-cmd
                        is not set in your .egrc and $VISUAL and $EDITOR are
                        not set, prints a message and does nothing."""
                        )

    parser.add_argument('command',
                        type=str,
                        nargs='?',
                        help="command to lookup")

    options,_ = parser.parse_known_args()

    if len(sys.argv) < 2:
        # Too few arguments. We can't specify this using argparse alone, so we
        # have to manually check.
        parser.print_help()
        parser.exit()

    colorama.init(strip=options.color)

    if options.update_tldr:
        print('Updating tldr pages')
        update_tldr_pages(remote=options.tldr_source)
        print('Update complete.\n')
        return

    if options.reindex:
        print('Reindexing ... ')
        build_index()
        print('Completed')
        return

    if options.list:
        print('\n'.join(list_commands()))
        return

    lang = options.language
    os = options.os
    command = options.command.split()[0]

    if options.find:
        location, other_pages_location = find_page_location(command, lang, os)
        print(*report_all_pages(location, other_pages_location))
    elif options.edit:
        edit_custom_page(command, lang, os)
    else:
        output_lines = parse_man_page(command, lang, os)
        msg = ''.join(output_lines)
        is_squeeze = get_config()['squeeze']
        pager_cmd = get_config()['pager']
        if pager_cmd:
            try:
                if is_squeeze and pager_cmd.startswith('less'):
                        pager_cmd = pager_cmd.rstrip()+' -s'
                pydoc.pipepager(msg, cmd=pager_cmd)
            except KeyboardInterrupt:
                pass
        else:
            print(msg)

    return 0
