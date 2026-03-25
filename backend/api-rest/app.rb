require "sinatra"
require "sinatra/json"
require "json"
# Estas líneas de código en la aplicación Ruby Sinatra 
# configuran el host y el puerto en el que la aplicación escuchará.

set :bind, "0.0.0.0"
set :port, ENV['PORT'] || 3000

# `tasks = []` inicializa una matriz vacía llamada `tasks`. 
# Esta matriz se usará para almacenar objetos de tarea en la aplicación Ruby Sinatra.
tasks = []


# `next_id = 1` inicializa la variable `next_id` con el valor 1. Esta variable se utiliza para
# registrar el siguiente ID disponible que se asignará a una nueva tarea al crearse. Cada
# vez que se agrega una nueva tarea, este valor de `next_id` 
# se incrementa para garantizar que cada tarea tenga un identificador único.
next_id = 1


# El bloque `before` de la aplicación Ruby Sinatra configura 
# los encabezados CORS (Intercambio de Recursos entre Orígenes) para la aplicación. 
# CORS es una función de seguridad implementada por los navegadores web 
# para impedir que las páginas web realicen solicitudes a un dominio diferente al que sirvió la página web original.
before do
  response.headers["Access-Control-Allow-Origin"] = "*"
  response.headers["Access-Control-Allow-Methods"] = "GET, POST, PUT, DELETE, OPTIONS"
  response.headers["Access-Control-Allow-Headers"] = "Content-Type"
end

# El bloque `options "*" do` en la aplicación Ruby Sinatra maneja las solicitudes del método HTTP OPTIONS
# para todas las rutas.
options "*" do
  200
end

# El bloque `get "/tasks" do` en la aplicación Ruby Sinatra define una ruta para manejar solicitudes GET
# al endpoint "/tasks". Cuando se realiza una solicitud GET a este endpoint, el bloque recupera
# todas las tareas almacenadas en el array `tasks` y las convierte a formato JSON usando el método `json`
# proporcionado por el framework Sinatra. Finalmente, devuelve la representación JSON de las tareas como
# respuesta al cliente que realiza la solicitud.
get "/tasks" do
  
  json tasks
end

# El bloque `get "/tasks/:id" do` en la aplicación Ruby Sinatra define una ruta para manejar solicitudes GET
# al endpoint "/tasks/:id". Cuando se realiza una solicitud GET a este endpoint con un ID de tarea específico
# proporcionado en la URL, el bloque busca una tarea en el array `tasks` cuyo ID coincida con el
# ID proporcionado en los parámetros de la solicitud (`params[:id]`).
get "/tasks/:id" do
  task = tasks.find { |t| t[:id] == params[:id].to_i }

 # Este bloque de código maneja la respuesta cuando se solicita una tarea específica por ID.
  if task
    json task
  else
    status 404
    body "No such task"
  end
end

# El bloque `post "/tasks" do` en la aplicación Ruby Sinatra maneja las solicitudes POST al
# endpoint "/tasks".
post "/tasks" do
  request.body.rewind
  data = JSON.parse(request.body.read) rescue {}

 # Las líneas `title = data["title"]` y `description = data["description"]` en el bloque `post "/tasks" do`
 # de la aplicación Ruby Sinatra extraen los valores de las claves "title" y "description"
 # de los datos JSON enviados en el cuerpo de la solicitud POST.
  title = data["title"]
  description = data["description"]
# La línea `halt 400, json(error: "Missing title or description") if title.nil? || description.nil?`
# en el bloque `post "/tasks"` de la aplicación Ruby Sinatra detiene la ejecución y devuelve un error 400
# si el título o la descripción están ausentes.

  halt 400, json(error: "Missing title or description") if title.nil? || description.nil?

# Este bloque de código crea un nuevo objeto de tarea con las siguientes propiedades:
  task = {
    id:          next_id,
    title:       title,
    description: description,
    done:        false
  }
# `next_id += 1` incrementa la variable `next_id` en 1, asegurando que el siguiente ID disponible para
# una nueva tarea sea único. Este paso es importante para mantener identificadores únicos para cada tarea en
# la aplicación.
  next_id += 1
  tasks << task

 # El código `status 201` establece el código de estado HTTP a 201, lo cual indica que un nuevo
 # recurso ha sido creado exitosamente. A continuación, `json task` convierte el objeto `task` a
 # formato JSON y lo devuelve como respuesta al cliente. Este bloque de código se utiliza típicamente en un
 # manejador de solicitudes POST para informar al cliente que la creación de la tarea fue exitosa y proporcionar
 # los detalles de la tarea recién creada en formato JSON.
  status 201
  json task
end

# El bloque `put "/tasks/:id" do` en la aplicación Ruby Sinatra define una ruta para manejar solicitudes PUT
# al endpoint "/tasks/:id".
put "/tasks/:id" do
  task = tasks.find { |t| t[:id] == params[:id].to_i }
  halt 404, json(error: "No such task") unless task

  # El código `request.body.rewind` rebobina el flujo de entrada de regreso al principio. Esto es
  # necesario porque el flujo ya ha sido leído en la línea anterior o en otro lugar, y
  # rebobinarlo permite leerlo nuevamente desde el inicio.
  request.body.rewind
  data = JSON.parse(request.body.read) rescue {}

  # Este bloque de código en el manejador de ruta `put "/tasks/:id"` actualiza las propiedades de un objeto
  # de tarea basándose en los datos proporcionados en el cuerpo de la solicitud PUT. Aquí está el desglose de lo que
  # hace cada línea:
  task[:title]       = data["title"]       if data.key?("title")
  task[:description] = data["description"] if data.key?("description")
  task[:done]        = data["done"]        if data.key?("done")

  json task
end

# El bloque `delete "/tasks/:id" do` en la aplicación Ruby Sinatra define una ruta para manejar
# solicitudes DELETE al endpoint "/tasks/:id".
delete "/tasks/:id" do
  task = tasks.find { |t| t[:id] == params[:id].to_i }
  halt 404, json(error: "Tarea no encontrada") unless task

 # El código `tasks.delete(task)` elimina la tarea especificada del array `tasks`. Borra el
 # objeto de tarea que coincide con la tarea proporcionada del array.
  tasks.delete(task)
  status 204
end
 run! if app_file == $0