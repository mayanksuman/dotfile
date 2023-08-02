#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
from os import path
import sys
import io
import json
from operator import itemgetter
import urllib.request
from urllib.error import HTTPError
from zipfile import ZipFile
import subprocess

from .config import get_config
from .parser import parse_page

def parse_man_page(command, language, platform):
    """Parse the man page and return the parsed lines."""
    page_path, other_pages_path = find_page_location(command,
                                                     language,
                                                     platform)
    output_lines = parse_page(page_path)
    return output_lines


def get_index():
    """Retrieve index in the pages directory."""
    data_directory = get_config()['data_directory']
    index_path = path.join(data_directory, 'index.json')
    if not path.exists(index_path):
        # Most probabibaly running first time
        print('Index not found. Update tldr pages and reindexing.')
        update_tldr_pages()
    with io.open(index_path, encoding='utf-8') as f:
        index = json.load(f)
    return index


def list_commands():
    """List commands in the pages directory."""
    index = get_index()
    return [item['name'] for item in index['commands']]


def find_page_location(command, specified_language, specified_platform):
    """Find the command man page in the pages directory."""
    default_platform = get_config()['platform']
    command_platform = (
        specified_platform if specified_platform else default_platform)
    index = get_index()
    command_list = list_commands()
    if command not in command_list:
        sys.exit(
            ("Sorry, we don't support command: {0} right now.\n"
             "You can file an issue or send a PR on github:\n"
             "    https://github.com/tldr-pages/tldr").format(command))
    src_lang_os = index['commands'][command_list.index(
                                       command)]['src_lang_os']
    supported_platforms = [src_lang_os.split(os.sep)[2]
                           for src_lang_os in src_lang_os]
    if command_platform in supported_platforms:
        platform = command_platform
    elif 'common' in supported_platforms:
        platform = 'common'
    else:
        platform = ''
    if not platform:
        sys.exit(
            ("Sorry, command {0} is not supported on your platform.\n"
             "You can file an issue or send a PR on github:\n"
             "    https://github.com/tldr-pages/tldr").format(command))

    sel_src_paths = [s for s in src_lang_os if platform in s]
    if specified_language:
        sel_src_paths = [s for s in sel_src_paths if specified_language in s]
    sel_custom_src_path = [s for s in sel_src_paths if '__custom__' in s]

    if sel_custom_src_path:
        page_src_path = sel_custom_src_path[0]
    else:
        page_src_path = sel_src_paths[0]

    page_path = resolve_source_path(page_src_path)
    other_pages_path = [resolve_source_path(s)
                        for s in sel_src_paths if s != page_src_path]
    return page_path, other_pages_path


def resolve_source_path(src_lang_os):
    repo_directory = get_config()['repo_directory']
    custom_pages_path = get_config()['custom_pages_directory']
    if '__custom__' in src_lang_os:
        page_dir = custom_pages_path
    else:
        page_dir = repo_directory
    page_path = path.join(page_dir, src_lang_os.split(os.sep, 1)[1])
    return page_path


def report_all_pages(page_path, other_pages_path):
    report = []
    report.append('Default tldr page: {0}\n\n'.format(page_path))
    if other_pages_path:
        report.append('Other tldr pages:\n')
        report.append('\n'.join(other_pages_path))
    return report


def build_index():
    repo_directory = get_config()['repo_directory']
    custom_page_path = get_config()['custom_pages_directory']
    data_directory = get_config()['data_directory']
    index_path = path.join(data_directory, 'index.json')

    # source custom location
    commands = _built_index_diff_source('custom', custom_page_path)
    # source official tldr pages
    commands = _built_index_diff_source('tldr', repo_directory, commands)

    command_list = [item[1] for item in
                    sorted(commands.items(), key=itemgetter(0))]
    new_index = {}
    new_index['commands'] = command_list

    with open(index_path, mode='w', encoding='utf-8') as f:
        json.dump(new_index, f)


def _built_index_diff_source(source_name, page_path, commands=None):
    source = '__' + source_name + '__'
    tree_generator = os.walk(page_path)
    commands = {} if commands is None else commands
    languages = next(tree_generator)[1]
    for language in languages:
        platforms = next(tree_generator)[1]
        for platform in platforms:
            pages = next(tree_generator)[2]
            for page in pages:
                if page.endswith('.md'):
                    command_name = path.splitext(page)[0]
                    src_lang_os = path.join(source, language, platform, page)
                    if command_name not in commands:
                        commands[command_name] = {'name': command_name,
                                              'src_lang_os': [src_lang_os]}
                    else:
                        commands[command_name]['src_lang_os'].append(
                            src_lang_os)
                elif page == 'alias.json':
                    commands = process_alias_file(page_path,
                                                  language,
                                                  platform,
                                                  source,
                                                  commands)
    return commands


def process_alias_file(page_path, language, platform, source, commands):
    alias_path = path.join(page_path, language, platform, 'alias.json')
    with io.open(alias_path, encoding='utf-8') as f:
        alias_dict = json.load(f)
    for alias in alias_dict:
        command_name = alias
        page = alias_dict[command_name] + '.md'
        if path.isfile(path.join(page_path, language, platform, page)):
                src_lang_os = path.join(source, language, platform, page)
                if command_name not in commands:
                    commands[command_name] = {'name': command_name,
                                              'src_lang_os': [src_lang_os]}
                else:
                    commands[command_name]['src_lang_os'].append(
                        src_lang_os)
    return commands


def update_tldr_pages(remote="https://tldr.sh/assets/tldr.zip"):
    tldr_pages_dir = get_config()['repo_directory']
    cur_dir = os.getcwd()
    os.chdir(tldr_pages_dir)
    if path.isdir('shell'):
        os.rename('shell', 'pages')
    try:
        opener=urllib.request.build_opener()
        opener.addheaders=[('User-Agent',"Mozilla/5.0 (Windows NT 6.1; WOW64) "
                            "AppleWebKit/537.36 (KHTML, like Gecko) "
                            "Chrome/36.0.1941.0 Safari/537.36")]
        urllib.request.install_opener(opener)
        urllib.request.urlretrieve(remote, 'tldr.zip')
    except HTTPError:
        print("Downloading tldr pages failed. HTTP error occured.")
    try:
        ZipFile('tldr.zip').extractall()
    except:
        pass
    if path.isfile('tldr.zip'):
        os.remove('tldr.zip')
    if path.isdir('pages'):
        os.rename('pages', 'shell')
    os.chdir(cur_dir)
    print('Reindexing ...')
    build_index()


def edit_custom_page(command, language, platform):
    custom_pages_dir = get_config()['custom_pages_directory']
    editor_cmd = get_config()['editor'].split()
    command_list = list_commands()
    if command not in command_list:
        file_name = create_custom_page_name(command, language, platform)
    else:
        def_page, other_page = find_page_location(command, language, platform)
        if custom_pages_dir in def_page:
            # Edit case
            file_name = def_page
        else:
            file_name = create_custom_page_name(command, language, platform)
    editor_cmd.append(file_name)
    subprocess.call(editor_cmd)
    build_index()


def create_custom_page_name(command, language, platform):
    custom_pages_dir = get_config()['custom_pages_directory']
    lang_platform_cobination = []
    tree_generator = os.walk(custom_pages_dir)
    languages = [language] if language else next(tree_generator)[1]
    for language in languages:
        platforms = [platform] if platform else next(tree_generator)[1]
        for platform in platforms:
            lang_platform_cobination.append((language, platform))
    print('The command {0} do not have example page'.format(command))
    print('Please select the (language, platform) combination to create new example page')
    for i in range(len(lang_platform_cobination)):
        print('{0} {1}'.format(i+1, lang_platform_cobination[i]))
    sel_index = input("Your Selection : ")
    sel_index = int(sel_index)-1
    if (sel_index >= 0 and sel_index < len(lang_platform_cobination)):
        sel_lang_os = lang_platform_cobination[sel_index]
        file_name = path.join(custom_pages_dir,
                              *sel_lang_os,
                              command+'.md')
        return file_name
    else:
        sys.exit("Invalid Selection")

