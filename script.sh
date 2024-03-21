#!/bin/bash

find /catalog -type f \( -name "*.php" -o -name "*.js" -o -name "*.html" -o -name "*.vue" -o -name "*.tpl" \) -exec bash -c 'echo "<h2>$1</h2>" && pygmentize -l javascript -f html -O full,style=colorful "$1" 2>/dev/null' _ {} \; > out.html
mv out.html /converted_pdf/origin.html
# Конвертация HTML файла в PDF с помощью LibreOffice
libreoffice --headless --convert-to pdf:writer_pdf_Export /converted_pdf/origin.html --outdir /converted_pdf