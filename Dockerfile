FROM ghcr.io/runatlantis/atlantis:vATLANTIS_VERSION

LABEL org.opencontainers.image.source=https://github.com/vitagroupag/atlantis-custom
LABEL org.opencontainers.image.description="A customized version of Atlantis"

# copy a terraform binary of the version you need
USER root
COPY terragrunt /usr/local/bin/terragrunt
RUN chmod 755 /usr/local/bin/terragrunt

# copy kubectl
COPY kubectl /usr/local/bin/kubectl
RUN chmod 755 /usr/local/bin/kubectl

# install AWS CLI
RUN apk update
RUN apk add aws-cli
