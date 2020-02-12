<template>
<div id="main" class="pt-16" style="  display: grid;
  grid-template-columns: 6rem auto; background: #f0f0f0; width: 10rem">
    <!-- Sidebar -->
    <div class="bg-grey-darkest relative h-full min-h-screen">
      <div class="xl:py-2">
        <div class="hidden xl:block uppercase font-bold text-grey-darker text-xs px-4 py-2">
          Main
        </div>
        <div class="group relative sidebar-item with-children">
          <a href="#" class="block xl:flex xl:items-center text-center xl:text-left shadow-light xl:shadow-none py-6 xl:py-2 xl:px-4 border-l-4 border-transparent hover:bg-black">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24" class="h-6 w-6 text-grey-darker fill-current xl:mr-2"><path d="M12 22a10 10 0 1 1 0-20 10 10 0 0 1 0 20zM5.68 7.1A7.96 7.96 0 0 0 4.06 11H5a1 1 0 0 1 0 2h-.94a7.95 7.95 0 0 0 1.32 3.5A9.96 9.96 0 0 1 11 14.05V9a1 1 0 0 1 2 0v5.05a9.96 9.96 0 0 1 5.62 2.45 7.95 7.95 0 0 0 1.32-3.5H19a1 1 0 0 1 0-2h.94a7.96 7.96 0 0 0-1.62-3.9l-.66.66a1 1 0 1 1-1.42-1.42l.67-.66A7.96 7.96 0 0 0 13 4.06V5a1 1 0 0 1-2 0v-.94c-1.46.18-2.8.76-3.9 1.62l.66.66a1 1 0 0 1-1.42 1.42l-.66-.67zM6.71 18a7.97 7.97 0 0 0 10.58 0 7.97 7.97 0 0 0-10.58 0z" class="heroicon-ui"></path></svg>
            <div class="text-white text-xs">Dashboard</div>
          </a>
        </div>
        <div class="group relative sidebar-item with-children">
          <div class="absolute xl:relative hidden xl:block pin-t left-full xl:pin-none w-48 xl:w-auto group-hover:block bg-black z-50 xl:z-auto">
          </div>
        </div>
        <div class="group relative sidebar-item with-children">
        </div>
      </div>
      <!-- Secondary Menu -->
      <div class="xl:py-2">
        <div class="hidden xl:block uppercase font-bold text-grey-darker text-xs px-4 py-2">
          Secondary
        </div>
        <div class="group relative sidebar-item with-children">
          <a href="#" class="block xl:flex xl:items-center text-center xl:text-left shadow-light xl:shadow-none py-6 xl:py-2 xl:px-4 border-l-4 border-transparent hover:bg-black">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24" class="h-6 w-6 text-grey-darker fill-current xl:mr-2"><path d="M12 12a5 5 0 1 1 0-10 5 5 0 0 1 0 10zm0-2a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm9 11a1 1 0 0 1-2 0v-2a3 3 0 0 0-3-3H8a3 3 0 0 0-3 3v2a1 1 0 0 1-2 0v-2a5 5 0 0 1 5-5h8a5 5 0 0 1 5 5v2z" class="heroicon-ui"></path></svg>
            <div class="text-white text-xs">Users</div>
          </a>
        </div>
      </div>
      <!-- Other Links -->
      <div class="py-4">
        <div class="hidden xl:block uppercase font-bold text-grey-darker text-xs px-4 py-2">
          Action
        </div>
        <div class="px-2">
          <a href="#" class="flex items-center justify-center py-2 w-full text-xs text-center text-white block bg-blue hover:bg-blue-dark rounded shadow-light font-bold">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24" class="h-4 w-4 mr-1 fill-current"><path d="M17 11a1 1 0 0 1 0 2h-4v4a1 1 0 0 1-2 0v-4H7a1 1 0 0 1 0-2h4V7a1 1 0 0 1 2 0v4h4z" class="heroicon-ui"></path></svg>
            Button
          </a>
        </div>
      </div>
    </div>
    <!-- Content -->
  </div>
</template>
<script>
export default {
  name: 'Sidebar',
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
