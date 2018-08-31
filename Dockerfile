FROM hugheylab/ubuntu

MAINTAINER "Jake Hughey" jakejhughey@gmail.com

RUN install.r drat \
  && echo "drat::addRepo('hugheylab')" >> ~/.Rprofile \
  && r -e 'setRepositories(ind = c(1:5, 9)); install.packages(c("metapredict", "zeitzeiger", "deltaccd", "limorhyde", "tipa"), type = "source")' \
  && rm -rf /tmp/downloaded_packages
