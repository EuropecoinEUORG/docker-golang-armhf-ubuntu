FROM armhf/ubuntu

RUN add-apt-repository ppa:longsleep/golang-backports

RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install --no-install-recommends -y curl ca-certificates git golang-go -y \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* /root/.cache

ENV GOPATH=/opt/go
ENV GOOS=linux
ENV GOARCH=arm
ENV GOARM=7


ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
WORKDIR $GOPATH

COPY go-wrapper /usr/local/bin/
RUN chmod +x /usr/local/bin/go-wrapper
