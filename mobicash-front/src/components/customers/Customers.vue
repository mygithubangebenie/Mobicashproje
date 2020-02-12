<template>
  <div class="m-auto py-10" style="width:80%;">
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
    <table class="table-auto">
    <thead>
    <tr>
      <th class="px-4 py-2">Name</th>
      <th class="px-4 py-2">Phone</th>
      <th class="px-4 py-2">Date of birth</th>
      <th class="px-4 py-2">Nationality</th>
      <th class="px-4 py-2">Action</th>
    </tr>
  </thead>
  <tbody v-for="customer in customers" :key="customer.id" :customer="customer">
    <tr>
      <td class="border px-4 py-2">{{ customer.name }}</td>
      <td class="border px-4 py-2">{{ customer.phone }}</td>
      <td class="border px-4 py-2">{{ customer.dob }}</td>
      <td class="border px-4 py-2">{{ customer.nationality }}</td>
      <td>           <button class="bg-tranparent text-sm hover:bg-blue hover:text-white text-blue border border-blue no-underline font-bold py-2 px-4 mr-2 rounded"
          @click.prevent="editCustomer(customer)">Edit</button>

          <button class="bg-transprent text-sm hover:bg-red text-red hover:text-white no-underline font-bold py-2 px-4 rounded border border-red"
         @click.prevent="removeCustomer(customer)">Delete</button></td>
    </tr>
  </tbody>
    </table>
      <form class="w-full max-w-sm" method="GET" action="http://localhost:3000/api/v1/customerpdf">
        <div class="flex items-center border-b border-b-2 border-teal-500 py-2">
           <input type="submit"  class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded" name="search_button" value="Print pdf">
        </div>
      </form></div>
</template>

<script>
export default {
  name: 'Customers',
  data () {
    return {
      customers: [],
      newCustomer: [],
      error: '',
      editedCustomer: ''
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
    }

  }
}
</script>
