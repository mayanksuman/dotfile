# awk
		A versatile programming language for working on text files.
		By default, columns/field in file are assumed to be space separated.
		Fields are 1-indexed, so, `$2` refers to the second column in a file.
		`$0` is special and means the whole line.


## Syntax

    awk options 'selection_criteria {action }' input-file

## Notable Options

		-f program-file : Reads the AWK program source from the file instead of
							command prompt
		-F ',' : Column are assumed to be comma separated

## Built In Variables

		NR : Current line/record number
		NF : Number of fields
		FS : Field separator for input file (default is space)
		RS : Record separator for input file (default is newline)
		OFS : Field separator used for output (default is space)
		ORS : Record separator used for output (default is newline)


## Examples

- Print lines matching `foo` or <pattern> (POSIX-style regular expression)

    awk '/foo/' input.txt
    awk '/<pattern>/' input.txt


- Find lines having `foo` and print the 2nd and 4th column

    awk '/foo/ {print $2,$4}' input.txt


- Print the 1st and last column of each line in a file, using a comma as a field separator

    awk -F ',' '{print $1,$NF}' filename


- Print line number and first column separated by '-'

    awk '{print NR "- " $1}' input.txt


- Print 2nd and 5th columns for line from 4 to 8

    awk 'NR==4, Nr==8 {print $2,$5}' input.txt


- Print all the lines having foo in third column

    awk '{ if($3 == "foo") print $0;}' input.txt


- Count the number of lines in file

    awk 'END { print NR }' input.txt


- Print every third line starting from the first line:

    awk 'NR%3==1' filename


- Sum the values in the first column of a file and print the total

    awk '{s+=$1} END {print s}' filename


- To find the length of the longest line present in the file:

    awk '{ if (length($0) > max) max = length($0) } END { print max }' input.txt


- Print the line having more than 10 character

    awk 'length($0) > 10' input.txt


- Print columns separated by : using for loop

    awk '{ for (i = 1; i < NF; i++) print $i":" }' input.txt


- Print square of numbers till 10

    awk 'BEGIN { for(i=1;i<=10;i++) print "square of", i, "is",i*i; }'
