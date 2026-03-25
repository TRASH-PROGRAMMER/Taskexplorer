<template>
  <section class="mb-8 bg-gradient-to-br from-rose-50 to-pink-50 border-2 border-rose-200 rounded-2xl p-6 md:p-8 shadow-sm">
    <div class="flex items-center gap-3 mb-5">
      <div class="w-10 h-10 bg-gradient-to-br from-rose-400 to-pink-500 rounded-xl flex items-center justify-center shadow-md">
        <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" />
        </svg>
      </div>
      <h2 class="text-xl font-bold text-rose-900">
        Crear nueva tarea
      </h2>
    </div>

    <form @submit.prevent="handleSubmit" class="grid gap-3 md:grid-cols-2">
      <div class="md:col-span-1">
        <label class="block text-sm font-medium text-slate-700 mb-1">
          Título
        </label>
        <input
          v-model="title"
          type="text"
          class="w-full rounded-xl border-2 border-rose-200 px-4 py-3 text-sm focus:outline-none focus:ring-2 focus:ring-rose-400 focus:border-rose-400 transition-all bg-white shadow-sm hover:border-rose-300"
          placeholder="Ej: Estudiar Vue 3"
          required
        />
      </div>

      <div class="md:col-span-1">
        <label class="block text-sm font-medium text-slate-700 mb-1">
          Descripción
        </label>
        <input
          v-model="description"
          type="text"
          class="w-full rounded-xl border-2 border-rose-200 px-4 py-3 text-sm focus:outline-none focus:ring-2 focus:ring-rose-400 focus:border-rose-400 transition-all bg-white shadow-sm hover:border-rose-300"
          placeholder="Ej: Ver documentación oficial"
          required
        />
      </div>

      <div class="md:col-span-2 flex justify-end gap-3 mt-3">
        <button
          type="button"
          class="px-5 py-2.5 rounded-xl text-sm font-medium border-2 border-rose-200 text-rose-700 hover:bg-rose-50 transition-all"
          @click="handleReset"
        >
          Limpiar
        </button>
        <button
          type="submit"
          class="px-6 py-2.5 rounded-xl text-sm font-bold bg-gradient-to-r from-rose-500 to-pink-500 text-white hover:from-rose-600 hover:to-pink-600 transition-all duration-200 shadow-lg hover:shadow-xl disabled:opacity-50 disabled:cursor-not-allowed transform hover:scale-105"
          :disabled="loading"
        >
          <span v-if="!loading">💾 Guardar tarea</span>
          <span v-else>⏳ Guardando...</span>
        </button>
      </div>
    </form>
  </section>
</template>

<script setup>
import { ref } from 'vue'

defineProps({
  loading: {
    type: Boolean,
    default: false
  }
})

// 👇 aquí cambiamos los nombres de los eventos
const emit = defineEmits(['create', 'reset'])

const title = ref('')
const description = ref('')

const handleSubmit = () => {
  if (!title.value || !description.value) return

  emit('create', {
    title: title.value,
    description: description.value
  })

  handleReset()
}

const handleReset = () => {
  title.value = ''
  description.value = ''
  emit('reset')
}
</script>


