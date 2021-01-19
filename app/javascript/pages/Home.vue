<template>
  <div id="app" class="home ">
    <div class="game-title">
      <form>
        <div class="form-group">
          <input type="text" class="form-control search" id="exampleInputEmail1"  placeholder="例 Fortnite">
        </div>
      </form>
      <div class="game-title-main">
        <p v-for="group in groups" :key="group">
          <a class="btn btn-outline-dark btn-block game-name" @click.prevent="fetchChannels(group.id)">{{ group.name }}</a>
        </p>
      </div>
    </div>
    <div class=" channels">
      <a class=" btn btn-outline-dark btn-block channels-name channle-create-button" data-toggle="modal" data-target="#Modal">channelを作成</a>
    <div class="modal fade" id="Modal" tabindex="-1" role="dialog" aria-labelledby="Modal" aria-hidden="true">
      <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="Modal">channel名を入力してください</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="閉じる">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body form-group">
            <input class="form-control" v-model="channel.name" placeholder="例 スライムの会" >
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">閉じる</button>
            <button type="button" class="btn btn-primary" @click.prevent="addChannel">保存</button>
          </div>
        </div>
      </div>
    </div>
      <p v-for="channel in channels" :key="channel.id">
        <a class="btn btn-outline-dark btn-block channels-name" @click.prevent="fetchComments(channel.id)">{{ channel.name }}</a>
      </p>
    </div>
    <div class=" talk-space">
      <div class="media" v-for="comment in comments" :key="comment.id">
        <div class="media-body">
          <h5 class="mt-0">{{ comment.user.nickname }}</h5>
          {{ comment.content }}
        </div>
      </div>
      <div class="message_form">
        <!-- <form @submit.prevent="addComment" class="form-inline">
            <input class="form-control comment-content" type="text" v-model="comment.content" placeholder="メッセージを入力してください">
            <button type="submit" class="btn btn-primary mb-2">Send</button>
        </form> -->
        <form @submit.prevent="addComment" class="message-main">
          <div class="message-box">
            <input type="text" class="form-control message-input" v-model="comment.content" placeholder="メッセージを入力してください">
            <label class="message_image">
              <i class="fas fa-image"></i>
              <input name="uploadedImage"  type="file" class="file_image" @change="onFileChange()">
            </label>
          </div>
          <div>
            <button type="submit" class="btn btn-primary mb-2 message-sendbtn">Send</button>
          </div>
        </form>
      </div>
   </div>
  </div>

</template>

<script>
import axios from 'axios'

export default {
  data: function () {
    return {
      groups: [],
      channels: [],
      channel:{
        name: ''
      },

      comments: [],
      comment: {
        content: ''
      },
      currentGroupId: null,
      currentChannelId: null,
      uploadedImage: ''
    }
  },
  methods: {
    fetchChannels(groupId) {
      this.currentGroupId = groupId
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
    addComment(){
      this.comment.channel_id = this.currentChannelId
      console.log(this.comment)
      axios.post('/comments.json', { comment: this.comment })
      // axios.post('/comments.json', ハッシュを渡しているため指定する必要がある→ { comment: this.comment })
        .then((response) => {
          this.comments.push(response.data)
          this.comment = {
            content: ''
          };
        })
        .catch((error) => {
          if (error.response.status) {
            alert('ログインが必要です')
          }
        })
    },
    addChannel(){
      this.channel.group_id = this.currentGroupId
      axios.post('/channels.json', { channel: this.channel })
      .then((response) => {
        this.channels.push(response.data)
        this.channel = {
          name: ''
        };
        this.uploadedImage = ''
        this.$refs.file.value = ''
      })
    },
    onFileChange() {
      let file = event.target.files[0] || event.dataTransfer.files
      let reader = new FileReader()
      reader.onload = () => {
        this.uploadedImage = event.target.result
        this.comment.image = this.uploadedImage
      }
      reader.readAsDataURL(file)
    },
  },
  mounted () {
    axios.defaults.headers.common = {
      "X-Requested-With": "XMLHttpRequest",
      "X-CSRF-TOKEN": document
        .querySelector('meta[name="csrf-token"]')
        .getAttribute("content"),
    };

    axios// mountedが読まれた後にaxiosが発動されて、.get('APIのURL')ゲットしたら、.then(成功したとき)に帰ってきたデータをthis.groupsに代入する
      .get('/groups.json')
      .then(response => (this.groups = response.data))
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>