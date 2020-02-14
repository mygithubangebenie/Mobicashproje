import Vue from 'vue'
import Router from 'vue-router'
import Try from '@/components/Try.vue'
import Signin from '@/components/Signin.vue'
import Signup from '@/components/Signup.vue'
import Customers from '@/components/customers/Customers.vue'
import NewCustomer from '@/components/customers/NewCustomer.vue'
Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      name: 'Signin',
      component: Signin
    },
    {
      path: '/signup',
      name: 'Signup',
      component: Signup
    },
    {
      path: '/newCustomer',
      name: 'NewCustomer',
      component: NewCustomer
    },
    {
      path: '/try',
      name: 'Try',
      component: Try
    },
    {
      path: '/customers',
      name: 'Customers',
      component: Customers
    }
  ]
})
