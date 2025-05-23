FROM bitnami/git:latest
RUN install_packages man git-man
ARG USER_NAME
ARG USER_ID
VOLUME ["/repo"]
VOLUME ["/home/$USER_NAME"]
WORKDIR /repo
RUN groupadd -g $USER_ID $USER_NAME && useradd -m -u $USER_ID -s /bin/bash -g $USER_NAME $USER_NAME
USER $USER_NAME
ENTRYPOINT ["git"]
CMD ["--version"]