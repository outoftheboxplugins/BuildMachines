FROM ghcr.io/epicgames/unreal-engine:dev-slim-5.0.3

LABEL org.opencontainers.image.source https://github.com/outoftheboxplugins/buildmachines

USER root

# update the base packages
RUN apt-get update -y
RUN apt-get install -y curl wget unzip jq 

# add over the start.sh script
ADD scripts/start.sh start.sh
RUN chmod +x start.sh

USER ue4

ENTRYPOINT ["./start.sh"]