<template>
  <div id="app">
    <Header/>
    <router-view></router-view>
    <Sidebar/>
  </div>
</template>

<script>
import Header from './components/Header.vue'
import Sidebar from './components/Sidebar.vue'
export default {
  name: 'App',
  components: {
    Header
    Sidebar
  }
}
</script>