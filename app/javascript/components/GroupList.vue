<template>
  <div class="game-title">
      <form @submit.prevent >
        <div class="form-group">
          <input type="text" @keyup="searchGroups" v-model="searchText" class="form-control search" id="exampleInputEmail1"  placeholder="例 Fortnite">
        </div>
      </form>
      <div class="game-title-box">
        <p v-for="group in groups" :key="group.id">
          <a class="btn btn-outline-dark btn-block game-name" v-bind:class="{ active: group.id === currentGroupId }" @click.prevent="fetchChannels(group.id)">{{ group.name }}</a>
        </p>
      </div>
    </div>
</template>

<script>
export default {
  props: {
    groups: {
      type: Array,
      required: true
    },
    currentGroupId: {
      type: Number
    }
  },
  data: function () {
    return {
      searchText: ''
    }
  },
  methods: {
    searchGroups() {
      this.$emit('searchGroups', this.searchText)
    },
    fetchChannels(groupId) {
      this.$emit('fetchChannels', groupId)
    }
  }
}
</script>