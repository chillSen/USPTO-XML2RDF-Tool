#!/bin/bash

#check upsto page for new zip files. Regex checks for files with '2014' and '2015' in url 
files=$(curl -s http://www.google.com/googlebooks/uspto-patents-grants-text.html | grep -E -o '(http://).*(2014|2015).*(zip)')

#set paths to your directories
inputDir=patents/
outputDir=turtle/
xslDir=xsl/


for line in $files
  do
   #if filename not in fileList -> download, unzip and converting
   if !(grep -Fxq $line fileList)
   then
    #get filename from fileurl
    filenameZip=$(grep -E -o '(ipg).*(zip)' <<< $line)
    echo "Found new File: $line"
    echo "starting download"
    (cd patents && curl -O $line)
    (cd patents && unzip $filenameZip)
    filenameXml=${filenameZip/.zip/.xml}
    java -jar XML2RDF.jar $inputDir$filenameXml $outputDir $xslDir/2013-2014.xsl
    echo $line >> fileList
    
    #cleaning directories
    rm $inputDir$filenameZip
    rm $inputDir$filenameXml
    rm tempfile.rdf
    rm temp.xml
   fi
done

