FROM ghcr.io/nrfconnect/sdk-nrf-toolchain:v3.1.1
RUN rm /opt/ncs/toolchains/*/nrfutil/home/locked
RUN nrfutil install sdk-manager=1.8.0
RUN nrfutil sdk-manager install v3.1.1
RUN rm /opt/.bashrc
