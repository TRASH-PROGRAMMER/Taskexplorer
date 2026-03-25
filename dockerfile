FROM node:18

# instalar ruby
RUN apt-get update && apt-get install -y ruby-full build-essential

WORKDIR /app

# copiar todo
COPY . .

# build frontend
WORKDIR /app/frontend/vue-project
RUN npm install && npm run build

# backend
WORKDIR /app/backend/api-rest
RUN gem install bundler && bundle install

EXPOSE 3000

CMD ["ruby", "app.rb"]