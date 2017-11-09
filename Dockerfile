FROM hugheylab/ubuntur

MAINTAINER "Jake Hughey" jakejhughey@gmail.com

RUN install.r devtools \
	&& r -e 'library(utils); source("https://bioconductor.org/biocLite.R"); biocLite(c("org.Hs.eg.db", "org.Mm.eg.db", "org.Dr.eg.db"))' \
	&& r -e 'devtools::install_github("hugheylab/metapredict", repos=BiocInstaller::biocinstallRepos())' \
	&& r -e 'devtools::install_github("hugheylab/zeitzeiger", repos=BiocInstaller::biocinstallRepos(), build_vignettes=TRUE, dependencies=TRUE)' \
	&& r -e 'devtools::install_github("hugheylab/deltaccd")' \
	&& rm -rf /tmp/downloaded_packages/
