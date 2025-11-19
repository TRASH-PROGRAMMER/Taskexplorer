require "sinatra"
require "sinatra/json"
require "json"

set :bind, "0.0.0.0"
set :port, 21000

tasks = []

next_id = 1


before do
  response.headers["Access-Control-Allow-Origin"] = "*"
  response.headers["Access-Control-Allow-Methods"] = "GET, POST, PUT, DELETE, OPTIONS"
  response.headers["Access-Control-Allow-Headers"] = "Content-Type"
end

options "*" do
  200
end

get "/tasks" do
  
  json tasks
end

get "/tasks/:id" do
  task = tasks.find { |t| t[:id] == params[:id].to_i }

  if task
    json task
  else
    status 404
    body "No such task"
  end
end

post "/tasks" do
  request.body.rewind
  data = JSON.parse(request.body.read) rescue {}

  title = data["title"]
  description = data["description"]

  halt 400, json(error: "Missing title or description") if title.nil? || description.nil?

  task = {
    id:          next_id,
    title:       title,
    description: description,
    done:        false
  }
  next_id += 1
  tasks << task

  status 201
  json task
end

put "/tasks/:id" do
  task = tasks.find { |t| t[:id] == params[:id].to_i }
  halt 404, json(error: "No such task") unless task

  request.body.rewind
  data = JSON.parse(request.body.read) rescue {}

  task[:title]       = data["title"]       if data.key?("title")
  task[:description] = data["description"] if data.key?("description")
  task[:done]        = data["done"]        if data.key?("done")

  json task
end

delete "/tasks/:id" do
  task = tasks.find { |t| t[:id] == params[:id].to_i }
  halt 404, json(error: "Tarea no encontrada") unless task

  tasks.delete(task)
  status 204
end
