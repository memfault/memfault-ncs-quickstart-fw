ARG NCS_VERSION=v3.2.0-preview2

FROM ghcr.io/nrfconnect/sdk-nrf-toolchain:${NCS_VERSION}
ARG NCS_VERSION
RUN rm /opt/ncs/toolchains/*/nrfutil/home/locked

# Manually install nRF-Connect SDK
RUN west init -m https://github.com/nrfconnect/sdk-nrf --mr ${NCS_VERSION} /opt/ncs/${NCS_VERSION} && \
    cd /opt/ncs/${NCS_VERSION} && \
    west update --narrow -o=--depth=1 && \
    west zephyr-export

# Save NCS version as an environment variable, for use in the container
ENV MEMFAULT_NCS_VERSION=${NCS_VERSION}

# Remove the built-in bashrc shim, it tries to install J-Link
RUN rm /opt/.bashrc
ENTRYPOINT ["/bin/bash", "-c", "source /opt/toolchain-env.sh && exec \"$@\"", "--"]
CMD ["/bin/bash"]

LABEL org.opencontainers.image.source="https://github.com/memfault/memfault-ncs-quickstart-fw"
