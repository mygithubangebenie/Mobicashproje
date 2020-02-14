<template>
  <div class="mx-auto py-10" style="width:80%;">
    <div class="text-red" v-if="error">{{ error }}</div>
    <h3 class="font-mono font-regular text-3xl mb-4">Add a new customer</h3>
    <form action="" @submit.prevent="addCustomer">
      <div class="mb-6">
        <input class="bg-white focus:outline-none focus:shadow-outline border border-gray-300 rounded-lg py-2 px-4 block w-full appearance-none leading-normal items-center justify-center"
          autofocus autocomplete="off"
          placeholder="Type a customer name"
          v-model="newCustomer.name" />
      </div>
        <div class="mb-6">
        <input class="bg-white focus:outline-none focus:shadow-outline border border-gray-300 rounded-lg py-2 px-4 block w-full appearance-none leading-normal items-center justify-center"
          autofocus autocomplete="off"
          placeholder="Type a customer phone"
          v-model="newCustomer.phone" />
      </div>
      <div class="mb-6">
        <input class="bg-white focus:outline-none focus:shadow-outline border border-gray-300 rounded-lg py-2 px-4 block w-full appearance-none leading-normal items-center justify-center"
          autofocus autocomplete="off"
          placeholder="Type a customer date of birth"
          v-model="newCustomer.dob" type="date" />
      </div>
        <div class="mb-6">
        <input class="bg-white focus:outline-none focus:shadow-outline border border-gray-300 rounded-lg py-2 px-4 block w-full appearance-none leading-normal items-center justify-center"
          autofocus autocomplete="off"
          placeholder="Type a customer nationality"
          v-model="newCustomer.nationality" />
      </div>
      <input type="submit" value="Add Customer" class="font-sans font-bold px-4 rounded cursor-pointer no-underline bg-green hover:bg-green-dark block w-full py-4 text-white items-center justify-center" />
    </form>
</div>
    </template>

<script>
import axios from 'axios'
export default {
  name: 'NewCustomer',
  data () {
    return {
      customers: [],
      newCustomer: [],
      error: '',
      editedCustomer: '',
      upc: '',
      productName: '',
      productCopmleted: '',
      productUser: '',
      productId: ''
    }
  },
  created () {
    if (!localStorage.signedIn) {
      this.$router.replace('/')
    } else {
      this.$http.secured.get('/api/v1/customers')
        .then(response => { this.customers = response.data })
        .catch(error => this.setError(error, 'Something went wrong'))
    }
  },
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    addCustomer () {
      const value = this.newCustomer
      if (!value) {
        return
      }
      this.$http.secured.post('/api/v1/customers/', { customer: { name: this.newCustomer.name, phone: this.newCustomer.phone, nationality: this.newCustomer.nationality, dob: this.newCustomer.dob } })
        .then(response => {
          this.customers.push(response.data)
          this.newCustomer = ''
          this.$router.replace('/customers')
        })
        .catch(error => this.setError(error, 'Cannot create customer'))
    },
    removeCustomer (customer) {
      this.$http.secured.delete(`/api/v1/customers/${customer.id}`)
        .then(response => {
          this.customers.splice(this.customers.indexOf(customer), 1)
        })
        .catch(error => this.setError(error, 'Cannot delete customer'))
    },
    editCustomer (customer) {
      this.editedCustomer = customer
    },
    updateCustomer (customer) {
      this.editedCustomer = ''
      this.$http.secured.patch(`/api/v1/customers/${customer.id}`, { customer: { name: customer.name } })
        .catch(error => this.setError(error, 'Cannot update customer'))
    },
    lookupUpc: function () {
      var thisApp = this
      thisApp.productName = 'Please wait...'
      axios.get('https://jsonplaceholder.typicode.com/todos/' + thisApp.upc)
        .then(function (response) {
          thisApp.productId = 'id:' + response.data.id
          thisApp.productUser = 'userId:' + response.data.userId
          thisApp.productName = 'title: ' + response.data.title
          thisApp.productCopmleted = 'completed:' + response.data.completed
        })
    }

  },
  watch: {
    upc: function () {
      this.productName = ''
      if (this.upc.length >= 1) {
        this.lookupUpc()
      }
    }
  }
}
</script>
