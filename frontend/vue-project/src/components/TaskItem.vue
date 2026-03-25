<template>
  <article
    class="group flex flex-col md:flex-row md:items-center gap-4 border-2 border-purple-200 rounded-2xl p-4 md:p-5 bg-gradient-to-br from-purple-50 to-pink-50 hover:shadow-lg hover:border-purple-300 transition-all duration-200 transform hover:-translate-y-1"
  >
    <div class="flex-1">
      <div class="flex items-center gap-2 mb-1">
        <input
          type="checkbox"
          :checked="task.done"
          @change="$emit('toggle')"
          class="h-5 w-5 rounded-lg border-2 border-purple-300 accent-purple-500 cursor-pointer hover:scale-110 transition-transform"
        />
        <h3
          class="text-lg font-bold transition-all"
          :class="task.done ? 'line-through text-purple-400' : 'text-purple-900 group-hover:text-indigo-700'"
        >
          {{ task.title }}
        </h3>
      </div>
      <p
        class="text-sm leading-relaxed transition-all"
        :class="task.done ? 'line-through text-purple-400' : 'text-purple-700'"
      >
        {{ task.description }}
      </p>

      <div class="mt-2">
        <span
          class="inline-flex items-center gap-2 px-3 py-1.5 rounded-full text-xs font-bold shadow-sm transition-all"
          :class="
            task.done
              ? 'bg-gradient-to-r from-emerald-100 to-teal-100 text-emerald-800 border-2 border-emerald-300'
              : 'bg-gradient-to-r from-amber-100 to-orange-100 text-amber-800 border-2 border-amber-300'
          "
        >
          <span class="w-2 h-2 rounded-full animate-pulse" :class="task.done ? 'bg-emerald-500' : 'bg-amber-500'"></span>
          {{ task.done ? '✓ Completada' : '⏳ Pendiente' }}
        </span>
      </div>
    </div>

    <div class="flex gap-2 justify-end">
      <button
        class="px-4 py-2 rounded-xl text-xs font-bold border-2 border-indigo-200 bg-white text-indigo-700 hover:bg-indigo-50 hover:border-indigo-300 transition-all transform hover:scale-105 shadow-sm"
        @click="$emit('edit')"
      >
        ✏️ Editar
      </button>
      <button
        class="px-4 py-2 rounded-xl text-xs font-bold border-2 border-red-200 bg-white text-red-600 hover:bg-red-50 hover:border-red-300 transition-all transform hover:scale-105 shadow-sm"
        @click="$emit('delete')"
      >
        🗑 Eliminar
      </button>
    </div>
  </article>
</template>

<script setup>
defineProps({
  task: {
    type: Object,
    required: true
  }
})

defineEmits(['toggle', 'edit', 'delete'])
</script>


