<template>
  <div class="talk-space">
    <div class="comment-box" id="toolbar-chat" ref="toolbarChat">
      <div class="media" v-for="comment in comments" :key="comment.id">
        <div class="media-body">
          <h5 class="mt-0">{{ comment.user.nickname }}</h5>
          <div>{{ comment.content }}</div>
          <img class="file_input" :src="comment.file_url" v-if="comment.file_url">
        </div>
      </div>
    </div>
    <div class="message_form">
      <form @submit.prevent="addComment" class="message-main" enctype="multipart/form-data">
        <div class="message-box">
          <input type="text" class="form-control message-input" v-model="comment.content" placeholder="メッセージを入力してください">
          <label class="message_image">
            <i class="fas fa-image"></i>
            <input name="uploadedImage"  type="file" class="file_image" @change="onFileChange">
          </label>
        </div>
        <div>
          <button type="submit" class="btn btn-primary mb-2 message-sendbtn">Send</button>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
export default {
  props:{
    comments:{
      type: Array,
      required: true
    },
  },
  data: function () {
    return {
      comment:{
        content: '',
      }
    }
  },
  methods:{
    addComment() {
      this.$emit('addComment',this.comment)
      this.comment = {content: ''}
    },
    onFileChange(e) {
      this.$emit('onFileChange',e)
    }
  }
}
</script>

<style>

</style>