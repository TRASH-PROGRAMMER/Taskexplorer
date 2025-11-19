<template>
  <div class="min-h-screen bg-gradient-to-br from-indigo-100 via-purple-50 to-pink-100 flex items-center justify-center px-4 py-8">
    <div class="w-full max-w-5xl bg-white/90 backdrop-blur-sm shadow-2xl rounded-3xl p-8 md:p-10 border-2 border-indigo-200">
      <!-- Header -->
      <TaskHeader :loading="loading" @reload="loadTasks" />

      <!-- Mensajes de error -->
      <div v-if="error" class="mb-6 p-4 rounded-2xl bg-gradient-to-r from-red-100 to-pink-100 border-2 border-red-300 text-red-800 text-sm shadow-lg">
        <div class="flex items-start gap-3">
          <span class="text-2xl">⚠️</span>
          <div>
            <p class="font-bold text-red-900">Error</p>
            <p class="mt-1">{{ error }}</p>
          </div>
        </div>
      </div>

      <!-- Formulario nueva tarea -->
      <TaskForm :loading="loading" @create="createTask" />

      <!-- Lista de tareas -->
      <TaskList
        :tasks="tasks"
        :loading="loading"
        @toggle="toggleDone"
        @edit="startEdit"
        @delete="deleteTask"
      />

      <!-- Modal de edición -->
      <EditTaskModal
        v-if="editingTask"
        :task="editingTask"
        @close="cancelEdit"
        @save="saveEdit"
      />
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import TaskHeader from './TaskHeader.vue'
import TaskForm from './TaskForm.vue'
import TaskList from './TaskList.vue'
import EditTaskModal from './EditTaskModal.vue'

const apiBase = 'http://localhost:21000'

const tasks = ref([])
const loading = ref(false)
const error = ref(null)

const editingTask = ref(null)

const resetError = () => {
  error.value = null
}

const loadTasks = async () => {
  loading.value = true
  resetError()
  try {
    const res = await fetch(`${apiBase}/tasks`)
    if (!res.ok) throw new Error('Error al cargar tareas')
    const data = await res.json()
    tasks.value = data
  } catch (e) {
    console.error(e)
    error.value = 'No se pudieron cargar las tareas.'
  } finally {
    loading.value = false
  }
}

const createTask = async ({ title, description }) => {
  if (!title || !description) return
  loading.value = true
  resetError()
  try {
    const res = await fetch(`${apiBase}/tasks`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ title, description })
    })
    if (!res.ok) throw new Error('Error al crear tarea')
    const created = await res.json()
    tasks.value.push(created)
  } catch (e) {
    console.error(e)
    error.value = 'No se pudo crear la tarea.'
  } finally {
    loading.value = false
  }
}

const toggleDone = async (task) => {
  resetError()
  try {
    const res = await fetch(`${apiBase}/tasks/${task.id}`, {
      method: 'PUT',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ done: !task.done })
    })
    if (!res.ok) throw new Error('Error al actualizar estado')
    const updated = await res.json()
    const index = tasks.value.findIndex((t) => t.id === task.id)
    if (index !== -1) tasks.value[index] = updated
  } catch (e) {
    console.error(e)
    error.value = 'No se pudo actualizar el estado de la tarea.'
  }
}

const deleteTask = async (task) => {
  resetError()
  const confirmDelete = window.confirm(
    `¿Seguro que quieres eliminar la tarea "${task.title}"?`
  )
  if (!confirmDelete) return

  try {
    const res = await fetch(`${apiBase}/tasks/${task.id}`, {
      method: 'DELETE'
    })
    if (!res.ok && res.status !== 204) throw new Error('Error al eliminar tarea')
    tasks.value = tasks.value.filter((t) => t.id !== task.id)
  } catch (e) {
    console.error(e)
    error.value = 'No se pudo eliminar la tarea.'
  }
}

const startEdit = (task) => {
  editingTask.value = { ...task }
}

const cancelEdit = () => {
  editingTask.value = null
}

const saveEdit = async (updatedData) => {
  if (!editingTask.value) return
  resetError()
  try {
    const res = await fetch(`${apiBase}/tasks/${editingTask.value.id}`, {
      method: 'PUT',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(updatedData)
    })
    if (!res.ok) throw new Error('Error al guardar cambios')
    const updated = await res.json()
    const index = tasks.value.findIndex((t) => t.id === updated.id)
    if (index !== -1) tasks.value[index] = updated
    editingTask.value = null
  } catch (e) {
    console.error(e)
    error.value = 'No se pudieron guardar los cambios.'
  }
}

onMounted(() => {
  loadTasks()
})
</script>
