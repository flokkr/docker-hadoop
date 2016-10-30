BEGIN {
   FS="="
}
{
   key = tolower($1)
   gsub("_",".",key)
   value = substr($2,2,length($2)-2)
   print "<property><name>" key "</name><value>" value "</value></property>"
}
