#!/bin/bash

# Выполнение заданной команды с предположением, что pygmentize заменяет ccat
#find /catalog -name "*.*" -type f -exec bash -c "echo '<h2>'"{}"'</h2>' && ccat -f html "{}"" \; > out.html
#find /catalog -name "*.*" -type f -exec bash -c 'echo "<h2>$1</h2>" && pygmentize -f html -O full,style=colorful "$1"' _ {} \; > out.html
find /catalog -type f \( -name "*.php" -o -name "*.js" -o -name "*.html" -o -name "*.vue" \) -exec bash -c 'echo "<h2>$1</h2>" && pygmentize -l javascript -f html -O full,style=colorful "$1" 2>/dev/null' _ {} \; > out.html
mv out.html /converted_pdf/origin.html
# Конвертация HTML файла в PDF с помощью LibreOffice
libreoffice --headless --convert-to pdf:writer_pdf_Export /converted_pdf/origin.html --outdir /converted_pdf

# Можно раскомментировать, если нужно переместить полученный PDF в определенное место
#mv /converted_pdf/origin/out.pdf /converted_pdf

#!/bin/bash
#
## Поиск файлов и создание HTML файла с подсветкой синтаксиса
#find /catalog -type f \( -name "*.php" -o -name "*.js" -o -name "*.html" -o -name "*.vue" \) -exec bash -c 'echo "<h2>$1</h2>" && pygmentize -l javascript -f html -O full,style=colorful "$1" 2>/dev/null' _ {} \; > out.html
#
## Перемещение out.html в директорию /converted_pdf/origin на будущее
#mv out.html /converted_pdf/origin/out.html
#
## Конвертация HTML файла в PDF с помощью LibreOffice
#libreoffice --headless --convert-to pdf:writer_pdf_Export /converted_pdf/origin/out.html --outdir /converted_pdf/origin
#
## Можно раскомментировать, если нужно переместить полученный PDF в определенное место
## (Теперь out.pdf будет находиться в директории /converted_pdf/origin)
#mv /converted_pdf/origin/out.pdf /converted_pdf