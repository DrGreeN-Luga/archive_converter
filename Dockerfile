# Основа на последнем Ubuntu
FROM ubuntu:latest

# Обновление списка пакетов и установка необходимых программ
RUN apt-get update && apt-get install -y \
    findutils \
    bash \
    python3 \
    python3-pip \
    libreoffice \
    coreutils

# Установка Pygments для подсветки синтаксиса
RUN pip3 install Pygments --break-system-packages
RUN pip3 install vue-lexer --break-system-packages

# Удаляем файлы, необходимые для установки, но не для выполнения программ
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Создадим символическую ссылку pygmentize на ccat для совместимости с использованием в скриптах
RUN ln -s /usr/bin/pygmentize /usr/local/bin/ccat

# Создаем рабочую директорию
RUN mkdir /converted_pdf

RUN mkdir /catalog
COPY ./catalog /catalog

COPY ./custom.css /styles/custom.css

#COPY ./script.sh ./script.sh
#RUN chmod +x /catalog/script.sh
# Ваш скрипт может потребовать скорректированной версии для корректного HTML и правильных путей к файлам
COPY script.sh /usr/local/bin/run-script
RUN chmod +x /usr/local/bin/run-script

# Настройка тома
#VOLUME ["/catalog"]
#VOLUME ["/conver"]

# Команда по умолчанию
CMD ["run-script"]