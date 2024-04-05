ARG PHP_VERSION=7.2
ARG NODE_VERSION=14
ARG PHP_EXTENSIONS="intl"

FROM thecodingmachine/php:$PHP_VERSION-v4-slim-cli

ADD https://getcomposer.org/download/latest-1.x/composer.phar /usr/local/bin/composer1
ADD https://getcomposer.org/download/latest-2.x/composer.phar /usr/local/bin/composer2

USER root

RUN apt-get update -q \
    && apt-get upgrade -y -q \
    && apt-get install -y patch rsync make jq \
    && rm -f /usr/local/bin/composer \
    && rm -rf ~/.composer \
    && cd /usr/local/bin/ \
    && chmod 755 composer1 composer2 \
    && ln -s composer2 composer \
    && apt-get autoremove -yq --purge \
    && apt-get autoclean -yq \
    && apt-get clean \
    && rm -rf /var/cache/apt/ /var/lib/apt/lists/* /var/log/* /tmp/* /var/tmp/* /usr/share/doc /usr/share/doc-base /usr/share/groff/* /usr/share/info/* /usr/share/linda/* /usr/share/lintian/overrides/* /usr/share/locale/* /usr/share/man/* /usr/share/locale/* /usr/share/gnome/help/*/* /usr/share/doc/kde/HTML/*/* /usr/share/omf/*/*-*.emf

USER docker
