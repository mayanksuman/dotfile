# RegEx

	A RegEx, or Regular Expression, is a sequence of characters that
	forms a search pattern. RegEx is composed of metacharacters, special
	sequences and set.

## Metacharacters
- Metacharacters are characters with a special meaning

Metacharacters 	Matches
[] 	A set of characters eg. [a-m]. See section on Set.
\ 	Signals a special sequence. See Special Sequence section.
. 	Matches with any character (except newline character) 	"he..o"
^ 	Line starts with 	"^hello"
$ 	Line or string ends with 	"world$"
?	Zero or one occurence of 'a' - "?a"
* 	Zero or more occurrences 	"a*"
+ 	One or more occurrences 	"a+"
{} 	exactly the specified number of occurences of preceeding character 	"a{2}"
{4,}	with 4 or more occurrences	"a{4,}"
{4,8}	with 4 to 8 occurrences	"a{4,}"
| 	Either or 	"falls|stays"
() 	Capture and group. eg. "(abd)" will search 'abd' together.

## Meta sequence
- A special sequence is a \ followed by one of the characters in the list below,
 and has a special meaning. Some meta sequences also play the role of anchors.

Meta Seq. 	Matches
\s 	any white space character, i.e., [ \t\r\n\v\f]
\S 	not a whitespace, i.e., [^ \t\r\n\v\f]
\w 	any word characters (i.e., characters from a to Z,
	digits from 0-9, and underscore _ character)
\W 	where the string DOES NOT contain any word characters
\d 	where string contains digits (i.e., 0-9)
\D 	where string DOES NOT contain digits
\xYY	Hex character YY
\ddd	Octal character ddd

## Anchors
- represents different positions in text.

Anchors		Matches
^	Start of line
$	End of line
\A 	start of string 	"\AThe"
\Z 	End of the string. Example: Spain at the end -- "Spain\Z"
\b 	word boundary (beginning or end of a word) 	"\bain" "ain\b"
\B 	opposite of \b, i.e., NOT at word boundary 	"\Bain" "ain\B"

## Set
- A set is a set of characters inside a pair of square brackets [] with a special meaning.
- Note: In sets, metacharacters like +, *, ., |, (), $,{} have no special meaning.
- Note: In sets, ^ work as NOT.

Set			Matches
[arn] 	where one of the specified characters (a, r, or n) are present
[a-n] 	for any lower case character, alphabetically between a and n
[^arn] 	for any character EXCEPT a, r, and n
[0123] 	where any of the specified digits (0, 1, 2, or 3) are present
[0-9] 	for any digit between 0 and 9
[0-5][0-9] 	for any two-digit numbers from 00 and 59
[a-zA-Z] 	for any alphabetical character, lower OR upper case
[+] 	any + character in the string. Metacharacter + has no special meaning.
[|] 	any | character in the string. Metacharacter | has no special meaning.

## Flags/Modifiers
- These character changes the option/preferences for RegEx match.

Flag	Description
i	Ignore Case
x	Ignore whitespace
g	Global Search
m	Multiline Search
s	Singleline Search
a	Restrict matches to ascii only
u	Enable unicode support
