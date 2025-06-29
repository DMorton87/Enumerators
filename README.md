# Enumerators
Simple scripts for enumerating host information and potentially sensitive files in a linux system.
Written in bash and pretty straightforward. There are definately other, more mature tools for this out there, but I wrote these for myself because the information overload that Linenum dumps into standard out makes me dizzy. These scripts will enumerate different categories of information, push the output to a .txt file, compress all the text files into an archive and then delete the text files, leaving you with one simple file to exfiltrate form your target system. 
