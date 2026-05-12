## RUNTIME
FROM node:22-bookworm-slim AS runtime

WORKDIR /app

# ENV NODE_ENV=production

COPY . .

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    ca-certificates \
    pandoc \
    texlive-xetex \
    texlive-fonts-recommended \
    lmodern\
  && rm -rf /var/lib/apt/lists/* \
  && npm install \
  && npm run build \
  && npm cache clean --force \
  && mkdir -p /app/uploads && chown -R node:node /app/uploads

USER node
EXPOSE 3000
CMD ["npm", "run", "app"]
