FROM paritytech/ci-linux:production as builder
WORKDIR /var/www/node-template
ADD . /var/www/node-template
ENV CARGO_HOME /var/www/node-template/.cargo
RUN bash -c "cargo build --release"

FROM debian:buster
COPY --from=builder /var/www/node-template/target/release/node-template /usr/local/bin

RUN /usr/local/bin/node-template --version
EXPOSE 9944
ENTRYPOINT ["/usr/local/bin/node-template"]
CMD ["--dev", "--ws-external", "--base-path", "/var/node-template"]
