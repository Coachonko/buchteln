FROM docker.io/eurolinux/eurolinux-9:latest

COPY . /tmp/buchteln

RUN set -x \
  && groupadd --system --gid 101 buchteln \
  && useradd --system --gid buchteln --create-home --home-dir /home/buchteln --shell /bin/bash --uid 101 buchteln \
  && dnf update --assumeyes \
  && dnf install --assumeyes git unzip java-21-openjdk \
  && dnf clean all \
  && rm -rf /var/cache/yum \
  && cd /home/buchteln \
  && curl -Lo new-lightweight.zip https://www.curseforge.com/api/v1/mods/520654/files/5611841/download \
  && unzip -oq new-lightweight.zip \
  && echo "eula=true" > eula.txt \
  && mv /tmp/buchteln/* /home/buchteln/ \
  && chmod +x /home/buchteln/start.sh \
  && chown -R buchteln:buchteln /home/buchteln

EXPOSE 25565

VOLUME /home/buchteln/buchteln

USER buchteln

WORKDIR /home/buchteln

CMD [ "/home/buchteln/start.sh" ]