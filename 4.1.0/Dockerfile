FROM rocker/tidyverse:4.1.0

LABEL author="Jake Hughey" \
  email="jakejhughey@gmail.com"

ENV TZ=America/Chicago

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
  && echo $TZ > /etc/timezone \
  && Rscript -e "remotes::install_github(c('r-lib/withr', 'r-lib/xml2', 'stephens999/ashr'))" \
  && Rscript -e "BiocManager::install(c('metapredict', 'zeitzeiger', 'deltaccd', 'limorhyde', 'tipa', 'simphony', 'spectr', 'pmparser', 'limorhyde2'), \
                 site_repository = 'https://hugheylab.github.io/drat/', \
                 update = FALSE, ask = FALSE)" \
  && rm -rf /tmp/downloaded_packages

CMD ["/bin/bash"]
