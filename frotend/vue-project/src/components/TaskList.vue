<template>
  <section class="bg-gradient-to-br from-blue-50 to-cyan-50 border-2 border-blue-200 rounded-2xl p-6 md:p-8 shadow-sm">
    <div class="flex items-center gap-3 mb-6">
      <div class="w-10 h-10 bg-gradient-to-br from-blue-400 to-cyan-500 rounded-xl flex items-center justify-center shadow-md">
        <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2" />
        </svg>
      </div>
      <h2 class="text-xl font-bold text-blue-900">
        Lista de tareas
      </h2>
    </div>

    <div v-if="loading && tasks.length === 0" class="text-center py-12">
      <div class="inline-block animate-spin rounded-full h-12 w-12 border-4 border-blue-200 border-t-blue-500"></div>
      <p class="mt-4 text-sm text-blue-700 font-medium">Cargando tareas...</p>
    </div>

    <div v-else-if="tasks.length === 0" class="text-center py-12">
      <div class="text-6xl mb-4">📭</div>
      <p class="text-blue-800 font-semibold text-lg">No hay tareas registradas</p>
      <p class="text-sm text-blue-600 mt-2">¡Crea tu primera tarea arriba! ✨</p>
    </div>

    <div class="space-y-3">
      <TaskItem
        v-for="task in tasks"
        :key="task.id"
        :task="task"
        @toggle="$emit('toggle', task)"
        @edit="$emit('edit', task)"
        @delete="$emit('delete', task)"
      />
    </div>
  </section>
</template>

<script setup>
import TaskItem from './TaskItem.vue'

defineProps({
  tasks: {
    type: Array,
    default: () => []
  },
  loading: {
    type: Boolean,
    default: false
  }
})

defineEmits(['toggle', 'edit', 'delete'])
</script>
