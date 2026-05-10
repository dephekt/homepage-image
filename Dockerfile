FROM hugomods/hugo:0.161.1 AS builder

WORKDIR /src
COPY . .

ARG DOMAIN
ENV DOMAIN=${DOMAIN}

# Ensure DOMAIN is provided so Hugo templating doesn't emit empty hostnames
RUN : "${DOMAIN:?DOMAIN build arg required}"

# Strip /static prefix from markdown files for Hugo build
RUN find content -type f -name "*.md" -exec sed -i 's|/static/images/|/images/|g' {} +

RUN hugo --minify --baseURL "/"

FROM nginx:1.27-alpine
COPY --from=builder /src/public /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
