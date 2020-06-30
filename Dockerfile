FROM r-base:3.6.3

LABEL author="Jake Hughey" \
  email="jakejhughey@gmail.com"

ENV TZ=America/Chicago

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
  && echo $TZ > /etc/timezone \
  && apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y \
  curl \
  git \
  libcurl4-gnutls-dev \
  libssh2-1-dev \
  libssl-dev \
  libxml2-dev \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && install.r BiocManager \
  && install.r drat \
  && echo "drat::addRepo('hugheylab')" >> ~/.Rprofile \
  && echo "drat::addRepo('hugheylab')" >> /etc/R/Rprofile.site \
  && r -e "BiocManager::install(c('metapredict', 'zeitzeiger', 'deltaccd', 'limorhyde', 'tipa', 'simphony'), ask = FALSE)" \
  && rm -rf /tmp/downloaded_packages

RUN wget https://github.com/jgm/pandoc/releases/download/2.10/pandoc-2.10-1-amd64.deb \
   && dpkg -i pandoc-2.10-1-amd64.deb \
   && rm -rf pandoc-2.10-1-amd64.deb

ENV PATH=/miniconda3/bin:${PATH}

RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
   && bash Miniconda3-latest-Linux-x86_64.sh -p /miniconda3 -b \
   && rm -rf Miniconda3-latest-Linux-x86_64.sh \
   && conda install -c conda-forge mamba \
   && mamba create -c conda-forge -c bioconda -n snakemake snakemake

CMD ["/bin/bash"]
