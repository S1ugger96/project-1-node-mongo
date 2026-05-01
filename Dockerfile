FROM node:18-slim AS builder
WORKDIR /app
ENV NODE_ENV=production
COPY package.json .
RUN npm install

FROM node:18-alpine
WORKDIR /app
COPY --from=builder /app/node_modules ./node_modules 
COPY server.js .
RUN apk add --no-cache curl
RUN adduser -D appuser
RUN chown -R appuser:appuser /app
USER appuser
EXPOSE 3000
HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
    CMD curl -f http://localhost:3000/ || exit 1
ARG APP_VERSION=1.0
CMD ["node", "server.js"]
