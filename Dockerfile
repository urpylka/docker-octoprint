# FROM python:3-slim-buster
# RUN apt-get update && apt-get install -y curl build-essential

FROM python:3-alpine
RUN apk --no-cache add build-base curl linux-headers

# RUN groupadd --gid 1000 octoprint \
#   && useradd --uid 1000 --gid octoprint -G dialout --shell /bin/bash -m octoprint \
#   && mkdir -p /octoprint/octoprint /octoprint/plugins \
#   && chown -R octoprint:octoprint /octoprint

RUN addgroup -g 1000 -S octoprint \
  && adduser -u 1000 -g octoprint -G dialout -s /bin/bash -D octoprint \
  && mkdir -p /octoprint/octoprint /octoprint/plugins \
  && chown -R octoprint:octoprint /octoprint

COPY config.yaml /octoprint/octoprint

USER octoprint

ENV PYTHONUSERBASE /octoprint/plugins
ENV PATH "${PYTHONUSERBASE}/bin:${PATH}"

RUN curl --create-dirs -o /home/octoprint/tmp/octoprint.tar.gz \
  -fsSL --compressed --retry 3 --retry-delay 10 \
  https://github.com/OctoPrint/OctoPrint/archive/1.7.2.tar.gz

RUN tar xzf /home/octoprint/tmp/octoprint.tar.gz --strip-components 1 -C /home/octoprint/tmp

RUN pip install /home/octoprint/tmp --no-cache-dir && rm -rf /home/octoprint/tmp

VOLUME /octoprint
WORKDIR /octoprint

EXPOSE 80
CMD octoprint serve --iknowwhatimdoing --host 0.0.0.0 --port 80 --basedir /octoprint/octoprint
