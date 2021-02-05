<template>
  <div id="app" class="home">
    <GroupList
      :groups="groups"
      :currentGroupId="currentGroupId"
      @searchGroups="searchGroups"
      @fetchChannels="fetchChannels"
    />
    <ChannelList
      :channels="channels"
      :currentChannelId="currentChannelId"
      @fetchComments="fetchComments"
      @addChannel="addChannel"
    />
    <CommentList
      :comments="comments"
      @addComment="addComment"
      @onFileChange="onFileChange"
    />
  </div>
</template>

<script>
import axios from 'axios'
import GroupList from '../components/GroupList.vue'
import ChannelList from '../components/ChannelList.vue'
import CommentList from '../components/CommentList.vue'

export default {
  components: {
    GroupList,
    ChannelList,
    CommentList
  },
  data: function () {
    return {
      groups: [],
      channels: [],
      comments: [],
      currentGroupId: null,
      currentChannelId: null,
      uploadFile: '',
      originGroups: []
    }
  },
  methods: {
    fetchChannels(groupId) {
      this.currentGroupId = groupId
      this.comments = []
      axios
      .get('/channels.json?group_id=' + groupId)
      .then(response => (this.channels = response.data))
    },
    fetchComments(channelId) {
      this.currentChannelId = channelId
      axios
      .get('/comments.json?channel_id=' + channelId)
      .then(response => (this.comments = response.data))
    },
    addComment(comment){
      const data = new FormData();    // multipart/form-data形式のため、new FormData()を使う
      data.append('comment[content]', comment.content);    // file形式以外も送信可能
      data.append('comment[file]', this.uploadFile);
      data.append('comment[channel_id]', this.currentChannelId)
      axios.post('/comments.json', data)
        .then((response) => {
          this.comments.push(response.data)
          this.uploadFile = ""

          this.$nextTick(() => {
            var container = this.$el.querySelector("#toolbar-chat");
            container.scrollTop = container.scrollHeight;
          });
        })
        .catch((error) => {
          if (error.response.status === 401) {
            alert('ログインが必要です')
          }
        })
    },
    addChannel(channel){
      channel.group_id = this.currentGroupId
      axios.post('/channels.json', { channel })
      .then((response) => {
        this.channels.push(response.data)
      })
    },
    onFileChange(e) {
      this.uploadFile = e.target.files[0] 
    },
    searchGroups(text) {
      this.groups = this.originGroups.filter(x => x.name.includes(text))
    }
  },
  mounted () {
    axios.defaults.headers.common = {
      "X-Requested-With": "XMLHttpRequest",
      "X-CSRF-TOKEN": document
        .querySelector('meta[name="csrf-token"]')
        .getAttribute("content"),
    };

    axios
      .get('/groups.json')
      .then(response => {
        this.groups = response.data
        this.originGroups = response.data
        this.currentGroupId = this.groups[0].id
        axios
          .get('/channels.json?group_id=' + this.currentGroupId)
          .then(response => {
            this.channels = response.data
            this.currentChannelId = this.channels[0].id
            this.fetchComments(this.currentChannelId)
            })
      })
  }
}

</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>