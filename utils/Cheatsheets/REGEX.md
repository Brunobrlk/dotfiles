# Groups and ranges
(abc) = Capture group
(a|b) = Match a or b
(?:abc) = Match but don't capture
\1 = Text matched from 1st capturing group
\2 = Text matched from 2st capturing group...
[b-fB-F] = Range from b to f and B to F(Uppercase)
[0-8] = Range from 0 to 8
[abc] = a, b or c
[^abc] = Not a, b or c

# Quantifiers
a* = 0 or more
a+ = 1 or more
a{3} = Exactly 3
a{5,} = 5 or more
a{,5} = 5 or less
a{3,5} = between 3 and 5

# Character
. = Any character except new line(\n)
\s = White space
\S = Not white space
\d = Digit
\D = Not digit
\w = Word
\W = Not word
\n = New line
\t = Tab

# Anchors
^ = Start of string/line(in multiline)
$ = End of string/line(in multiline)
\A = Start of string
\Z = End of string
\b = Word boundary
\B = Not word boundary
\< = Start of word
\> = End of word
\G = Start of match

# Modifiers
g = Global match
i = Ignore case
m = Multiple lines
s = Treat string as a single line
e = Evaluate replacement
