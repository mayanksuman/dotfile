# pdftk
		A tool for manipulating pdf files

## Syntax

    pdftk <input pdf files> operation operation_argument output <output_file_name>

## Sample Use-cases

1. Extract pages 2-4, 7-8 and 10 to a new pdf file

```
pdftk <input_file.pdf> cat 2-4 7-8 10 output <output_file.pdf>
```

2. Extract pages 2-6 from input1.pdf and page 7-10 from input2.pdf to a new pdf file

```
pdftk A=input1.pdf B=input2.pdf cat A2-6 B7-10 output <output_file.pdf>
```

3. Rotate page 2 from input1.pdf and save it as rotated_page2.pdf

```
pdftk input1.pdf cat 2east output rotated_page2.pdf
```

Possible rotation directions are "north", "south", "east", "west", "left", "right" or "down".

4. Separate out "even" or "odd" pages 

```
pdftk input1.pdf cat even output input_even.pdf
```
