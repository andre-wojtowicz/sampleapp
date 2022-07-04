FROM rocker/r-base:4.2.1

RUN apt update && \
    apt install -y --no-install-recommends \
        sudo \
        libcurl4-gnutls-dev \
        libcairo2-dev \
        libxt-dev \
        libssl-dev \
        libssh2-1-dev && \
    rm -rf /var/lib/apt/lists/*

RUN install.r packrat

RUN addgroup --system app && \
    adduser --system --ingroup app app

WORKDIR /home/app

COPY app .Rprofile .
COPY packrat/init.R packrat/packrat.lock packrat/packrat.opts ./packrat/

RUN chown app:app -R /home/app

RUN echo "local(options(shiny.port = 3838, shiny.host = '0.0.0.0'))" > /usr/lib/R/etc/Rprofile.site

USER app

RUN R -e 'packrat::restore()'

EXPOSE 3838

CMD ["R", "-e", "shiny::runApp('/home/app')"]
