<template>
  <div class="fixed inset-0 bg-indigo-900/50 backdrop-blur-sm flex items-center justify-center z-50 p-4">
    <div class="bg-gradient-to-br from-white to-indigo-50 rounded-3xl shadow-2xl w-full max-w-lg border-2 border-indigo-200 transform transition-all">
      <div class="bg-gradient-to-r from-indigo-500 to-purple-500 rounded-t-3xl p-6 text-white">
        <h2 class="text-2xl font-bold flex items-center gap-3">
          <span class="text-3xl">✏️</span>
          Editar tarea
        </h2>
        <p class="text-indigo-100 text-sm mt-1">ID: #{{ localTask.id }}</p>
      </div>
      <div class="p-6">

        <div class="space-y-5">
          <div>
            <label class="block text-sm font-bold text-indigo-900 mb-2">
              📌 Título
            </label>
            <input
              v-model="localTask.title"
              type="text"
              class="w-full rounded-xl border-2 border-indigo-200 px-4 py-3 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-400 focus:border-indigo-400 transition-all hover:border-indigo-300 bg-white shadow-sm"
            />
          </div>
          <div>
            <label class="block text-sm font-bold text-indigo-900 mb-2">
              📝 Descripción
            </label>
            <textarea
              v-model="localTask.description"
              rows="3"
              class="w-full rounded-xl border-2 border-indigo-200 px-4 py-3 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-400 focus:border-indigo-400 transition-all hover:border-indigo-300 bg-white shadow-sm resize-none"
            ></textarea>
          </div>
          <div class="flex items-center gap-3 p-4 bg-indigo-50 rounded-xl border-2 border-indigo-200">
            <input
              type="checkbox"
              v-model="localTask.done"
              class="h-5 w-5 rounded-lg border-2 accent-indigo-500 cursor-pointer"
            />
            <span class="text-sm font-semibold text-indigo-900">Marcar como completada</span>
          </div>
        </div>

        <div class="flex justify-end gap-3 mt-6">
          <button
            class="px-6 py-3 rounded-xl text-sm font-bold border-2 border-indigo-200 text-indigo-700 hover:bg-indigo-50 hover:border-indigo-300 transition-all"
            @click="$emit('close')"
          >
            Cancelar
          </button>
          <button
            class="px-6 py-3 rounded-xl text-sm font-bold bg-gradient-to-r from-indigo-500 to-purple-500 text-white hover:from-indigo-600 hover:to-purple-600 transition-all duration-200 shadow-lg hover:shadow-xl transform hover:scale-105"
            @click="handleSave"
          >
            💾 Guardar cambios
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { reactive, watch } from 'vue'

const props = defineProps({
  task: {
    type: Object,
    required: true
  }
})

const emit = defineEmits(['close', 'save'])

const localTask = reactive({
  id: props.task.id,
  title: props.task.title,
  description: props.task.description,
  done: props.task.done
})

watch(
  () => props.task,
  (newTask) => {
    if (!newTask) return
    localTask.id = newTask.id
    localTask.title = newTask.title
    localTask.description = newTask.description
    localTask.done = newTask.done
  },
  { deep: true }
)

const handleSave = () => {
  emit('save', {
    title: localTask.title,
    description: localTask.description,
    done: localTask.done
  })
}
</script>
