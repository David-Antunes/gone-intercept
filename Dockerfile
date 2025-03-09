FROM nicolaka/netshoot

WORKDIR /app

COPY script.sh script.sh

RUN chmod +x start.sh

CMD ["./script.sh"]

