#!/bin/bash

# build frontend
cd frontend/vue-project
npm install
npm run build

# backend
cd ../../backend/api-rest
bundle install

# run app
ruby app.rb