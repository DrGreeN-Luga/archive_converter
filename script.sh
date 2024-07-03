#!/bin/bash

output_path="/converted_pdf"
search_path="/catalog"

# Извлечение названия первого подкаталога после /catalog
# Предполагается, что путь имеет формат /catalog/подкаталог/...
top_dir_name=$(find "$search_path" -mindepth 1 -maxdepth 1 -type d | head -n 1 | xargs basename)
#top_dir_name=$(basename "$top_dir")

# Генерация начала файла HTML с названием каталога
{
echo '<!DOCTYPE html>'
echo '<html>'
echo '<head><title>Code Listing</title>'
echo '<style type="text/css">'
cat /styles/custom.css
echo '</style></head><body>'
echo "<h1>Проект: ${top_dir_name}</h1>"
} > "$output_path/origin.html"

# Поиск и обработка файлов с подсветкой синтаксиса и добавление имени файла в <h2>
find "$search_path" -mindepth 2 -type f \( -name "*.php" -o -name "*.js" -o -name "*.html" -o -name "*.vue" -o -name "*.tpl" -o -name "*.go" -o -name "*.sum" \) -exec bash -c 'filename=$(basename -- "$1"); echo "<h2>Файл: ${filename}</h2>"; pygmentize -f html -O full,style=colorful -g "$1"' _ {} \; >> "$output_path/origin.html"

# Закрытие тегов HTML
echo '</body></html>' >> "$output_path/origin.html"

# Конвертация HTML файла в PDF с помощью LibreOffice
libreoffice --headless --convert-to pdf:writer_pdf_Export "$output_path/origin.html" --outdir "$output_path"

mv "$output_path/origin.pdf" "$output_path/$top_dir_name.pdf"