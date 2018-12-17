FROM r-base:3.5.1

LABEL author="Jake Hughey" \
  email="jakejhughey@gmail.com"

ENV TZ=America/Chicago

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
  && echo $TZ > /etc/timezone \
  && apt-get update \
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
  && r -e 'setRepositories(ind = c(1:5, 9)); install.packages(c("metapredict", "zeitzeiger", "deltaccd", "limorhyde", "tipa", "simphony"), type = "source", quiet = TRUE)' \
  && rm -rf /tmp/downloaded_packages

RUN wget https://github.com/jgm/pandoc/releases/download/2.5/pandoc-2.5-1-amd64.deb \
   && dpkg -i pandoc-2.5-1-amd64.deb \
   && rm -rf pandoc-2.5-1-amd64.deb

ENV PATH=/miniconda3/bin:${PATH}

RUN wget https://repo.continuum.io/miniconda/Miniconda3-4.5.11-Linux-x86_64.sh \
   && bash Miniconda3-4.5.11-Linux-x86_64.sh -p /miniconda3 -b \
   && rm -rf Miniconda3-4.5.11-Linux-x86_64.sh \
   && conda update -y conda \
   && conda install -y -c bioconda -c conda-forge snakemake

CMD ["/bin/bash"]
