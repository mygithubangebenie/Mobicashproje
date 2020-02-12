<template>
  <div id="app">
    <Header v-if="signedIn()"/>
    <div style="   display: flex;
  justify-content: space-between;
  box-sizing: border-box">
    <Sidebar v-if="signedIn()"/>
        <router-view />
    </div>
  </div>
</template>

<script>
import Header from '@/components/Header.vue'
import Sidebar from '@/components/Sidebar.vue'
export default {
  name: 'App',
  components: {
    Header,
    Sidebar
  },
  created () {
    this.signedIn()
  },
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    signedIn () {
      return localStorage.signedIn
    },
    signOut () {
      this.$http.secured.delete('/signin')
        .then(response => {
          delete localStorage.csrf
          delete localStorage.signedIn
          this.$router.replace('/')
        })
        .catch(error => this.setError(error, 'Cannot sign out'))
    }
  }
}
</script>
