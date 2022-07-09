FROM rstudio/r-base:4.2.1-focal

RUN apt update && \
    apt install -y --no-install-recommends \
        sudo \
        libcurl4-gnutls-dev \
        libcairo2-dev \
        libxt-dev \
        libssl-dev \
        libssh2-1-dev && \
    rm -rf /var/lib/apt/lists/*

RUN addgroup --system app && \
    adduser --system --ingroup app app

RUN echo "local(options(shiny.port = 3838, shiny.host = '0.0.0.0'))" > /usr/lib/R/etc/Rprofile.site
RUN R -q --no-save -e 'chooseCRANmirror(FALSE, 1); install.packages("renv")'

USER app

WORKDIR /home/app

COPY --chown=app:app .Rprofile renv.lock .
COPY --chown=app:app renv/activate.R renv/settings.dcf ./renv/
RUN R -q --no-save -e 'library(renv); restore()'

COPY --chown=app:app app .

RUN R -q --no-save -e 'shiny::runTests(".")'
RUN rm -rf tests/

EXPOSE 3838

CMD ["R", "-e", "shiny::runApp('/home/app')"]
