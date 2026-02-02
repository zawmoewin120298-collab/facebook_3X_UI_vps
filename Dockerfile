FROM ghcr.io/mhsanaei/3x-ui:latest
RUN apk update && apk add --no-cache curl bash
EXPOSE 2053
CMD ["/app/x-ui"]
