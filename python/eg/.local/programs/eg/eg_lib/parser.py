#!/usr/bin/env python
# -*- coding: utf-8 -*-

from __future__ import absolute_import

import io
import click

from .config import get_config


def parse_page(page):
    """Parse the command man page."""
    colors = get_config()['colors']
    is_squeeze = get_config()['squeeze']
    with io.open(page, encoding='utf-8') as f:
        lines = f.readlines()
    output_lines = ['\n']
    is_inside_code_block = False
    for line in lines:
        if is_headline(line):
            output_lines.append(process_headline(line, colors))
        elif is_description(line):
            if is_squeeze and is_line_break(output_lines[-1]):
                output_lines.pop()
            output_lines.append(process_description_line(line, colors))
        elif is_old_usage(line):
            output_lines.append(process_usage_line(line, colors))
        elif is_code_block_marker(line):
            is_inside_code_block = not(is_inside_code_block)
            continue
        elif is_code_example(line) or is_inside_code_block:
            if is_squeeze and is_line_break(output_lines[-1]):
                output_lines.pop()
            output_lines.append(process_code_line(line, colors))
        elif is_line_break(line):
            if is_squeeze and is_line_break(output_lines[-1]):
                pass
            else:
                output_lines.append(line)
        else:
            output_lines.append(process_usage_line(line, colors))
    return output_lines[1:]


def is_headline(line):
    return click.unstyle(line).startswith(('#', '='))


def is_description(line):
    return click.unstyle(line).startswith('>')


def is_old_usage(line):
    return click.unstyle(line).startswith('-')


def is_code_block_marker(line):
    line = click.unstyle(line).strip()
    return (line[:3] == "```")


def is_code_example(line):
    line = click.unstyle(line)
    # check if enclosed by ``
    start_check = line.startswith('`')
    end_check = line.rstrip().endswith('`')
    num_marker = line.count('`')
    is_code = (start_check and end_check and num_marker == 2)
    # check if space indented block
    num_white_char_left = len(line)-len(line.lstrip())
    is_code = is_code or (line.startswith('    ') and num_white_char_left == 4)
    # check if tab indented
    is_code = is_code or ((line[0] == '\t') and num_white_char_left == 1)
    return is_code


def is_line_break(line):
    return click.unstyle(line).startswith("\n")


def _color_text_block(line,
                      start_marker,
                      end_marker,
                      color_in,
                      color_out,
                      preserve_marker=False):
    """Color the block of text between start_marker and end_marker.

    with color_in
    """
    color_reset_text = click.style('', fg='reset')
    replace_open = color_reset_text + click.style('',
                                                  fg=color_in, reset=False)
    replace_close = color_reset_text + click.style('',
                                                   fg=color_out, reset=False)

    if preserve_marker:
        replace_open = start_marker + replace_open
        replace_close = replace_close + end_marker

    if start_marker == end_marker:
        line_p = line.split(start_marker)
        for i in range(1, len(line_p), 2):
            line_p[i] = replace_open + line_p[i] + replace_close
        line = ''.join(line_p)
    else:
        line = line.replace(start_marker, replace_open)
        line = line.replace(end_marker, replace_close)

    return line


def _color_command_option(line, color_in, color_out):
    """Color the command options given in usage or desription inside []."""
    line = _color_text_block(line,
                             '[',
                             ']',
                             color_in,
                             color_out,
                             preserve_marker=True)

    return line


def _color_command_parameter(line, color_in, color_out):
    """Color the parameters in code examples."""
    line = _color_text_block(line,
                             '{{',
                             '}}',
                             color_in,
                             color_out,
                             preserve_marker=False)

    return line


def _color_inline_command(line, color_in, color_out):
    """Color the inline commands in usage or description."""
    line = _color_text_block(line,
                             '`',
                             '`',
                             color_in,
                             color_out,
                             preserve_marker=True)

    return line


def process_code_line(line, colors):
    """Color the example command lines."""
    default_color = colors['command']
    line = line.strip()
    line = line[1:] if line.startswith(('`', '\t')) else line
    line = line[:-1] if line.endswith('`') else line
    line = '    ' + line

    line = _color_command_parameter(line, colors['parameter'], default_color)
    line = click.style(line, fg=default_color)

    return line + '\n'


def process_usage_line(line, colors):
    """Color the usage line."""
    default_color = colors['usage']

    line = _color_command_option(line, colors['command'], default_color)
    line = _color_inline_command(line, colors['command'], default_color)
    line = _color_command_parameter(line, colors['parameter'], default_color)
    line = click.style(line, fg=default_color)

    return line


def process_description_line(line, colors):
    """Color the description line."""
    default_color = colors['description']
    if line[0] == '>' or line[:2] == ' >':
        line = line.replace('>', ' ', 1)

    line = _color_command_option(line, colors['command'], default_color)
    line = _color_inline_command(line, colors['command'], default_color)
    line = _color_command_parameter(line, colors['parameter'], default_color)
    line = click.style(line, fg=default_color)

    return line


def process_headline(line, colors):
    """Color the headline."""
    line = click.style(line,  fg=colors['headline'], bold=True, reverse=True)
    # line_p = line.split(' ', 1)
    # line_p[0] = click.style(line_p[0], fg='black', reverse=True)
    # line_p[1] = click.style(line_p[1], fg=colors['headline'], bold=True, reverse=True)

    return line
    # return ' '.join(line_p).rstrip()
