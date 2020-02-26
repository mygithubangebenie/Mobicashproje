<template>
  <header class=".bg-gray-200 py-4" style="background: grey;border-bottom:1px solid white" >
    <div class="container m-auto flex flex-wrap items-center justify-end">
      <div class="flex-1 flex items-center">
        <svg class="fill-current text-indigo" viewBox="0 0 24 24" width="24" height="24"><title>customer vinyl</title><path d="M23.938 10.773a11.915 11.915 0 0 0-2.333-5.944 12.118 12.118 0 0 0-1.12-1.314A11.962 11.962 0 0 0 12 0C5.373 0 0 5.373 0 12s5.373 12 12 12 12-5.373 12-12c0-.414-.021-.823-.062-1.227zM12 16a4 4 0 1 1 0-8 4 4 0 0 1 0 8zm0-5a1 1 0 1 0 0 2 1 1 0 0 0 0-2z"></path></svg>

        <a href="/" class="uppercase text-sm font-mono pl-4 font-semibold no-underline text-indigo-dark hover:text-indigo-darker">Customers Project</a>
      </div>
      <form method="GET" action="http://dev.mobivat.com:8080/vsdc_module/mobivat/api/product/productId?upc=224444445" v-if="signedIn()">
        <input type="text" name="upc" class="search form-control" style="float:left;width:70%;" placeholder="search product by upc">&nbsp;
        <input type="submit" class="btn btn-outline-light btn-sm" style="padding:6px" name="search_button" value="Search">
      </form>&nbsp;
      <div>
        <router-link to="/" class="link-grey px-2 no-underline" v-if="!signedIn()">Sign in</router-link>
        <router-link to="/signup" class="link-grey px-2 no-underline" v-if="!signedIn()">Sign Up</router-link>
        <router-link to="/customers" class="link-grey px-2 no-underline" v-if="signedIn()">Customers</router-link>
         <a href="#" @click.prevent="signOut" class="link-grey px-2 no-underline" v-if="signedIn()">Sign out</a>
      </div>
    </div>
  </header>
</template>

<script>
import axios from 'axios'
export default {
  name: 'Header',
  created () {
    this.signedIn()
  },
  data () {
    return {
      upc: '',
      productName: ''
    }
  },
  watch: {
    upc: function () {
      this.productName = ''
      if (this.upc.length === 1) {
        this.lookupUpc()
      }
    }
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
    },
    lookupUpc: function () {
      var thisApp = this
      thisApp.productName = 'Please wait...'
      axios.get('https://jsonplaceholder.typicode.com/todos/' + thisApp.upc)
        .then(function (response) {
          thisApp.productName = 'Todo: ' + response.data.title
        })
    }
  }
}
</script>
