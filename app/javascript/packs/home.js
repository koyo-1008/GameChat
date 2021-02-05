import Vue from 'vue'
import Home from '../pages/Home.vue'

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#home',
    render: h => h(Home)
  })
})