FROM node:20-alpine AS build
WORKDIR /app

# Enable Yarn
RUN corepack enable

COPY package.json yarn.lock ./

# Force Yarn to install EVERYTHING, including devDependencies
RUN yarn install --production=false --frozen-lockfile

COPY . .

# Bypass the "tsc" script and build the Vite bundle directly
RUN yarn run vite build

FROM node:20-alpine AS runtime
WORKDIR /app

RUN npm install -g serve

COPY --from=build /app/dist ./dist

EXPOSE 3000
CMD ["serve", "-s", "dist", "-l", "3000"]