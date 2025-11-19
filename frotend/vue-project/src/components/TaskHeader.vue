<template>
  <header class="flex flex-col md:flex-row md:items-center md:justify-between gap-4 mb-8">
    <div>
      <h1 class="text-3xl md:text-4xl font-bold text-indigo-900 tracking-tight mb-2">
        ✨ Taskexplorer
      </h1>
      <p class="text-sm text-slate-600 flex items-center gap-2">
        <span class="inline-block w-2 h-2 bg-emerald-400 rounded-full animate-pulse"></span>
        <span>Vue 3 + Sinatra REST API</span>
      </p>
    </div>
    <button
      class="inline-flex items-center justify-center gap-2 px-5 py-3 rounded-xl text-sm font-semibold bg-gradient-to-r from-indigo-500 to-purple-500 text-white hover:from-indigo-600 hover:to-purple-600 transition-all duration-200 shadow-lg hover:shadow-xl disabled:opacity-50 disabled:cursor-not-allowed transform hover:scale-105"
      @click="$emit('reload')"
      :disabled="loading"
    >
      <svg v-if="!loading" class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15" />
      </svg>
      <svg v-else class="animate-spin h-4 w-4" viewBox="0 0 24 24">
        <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4" fill="none"></circle>
        <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
      </svg>
      <span>{{ loading ? 'Actualizando...' : 'Actualizar' }}</span>
    </button>
  </header>
</template>

<script setup>
defineProps({
  loading: {
    type: Boolean,
    default: false
  }
})
</script>
