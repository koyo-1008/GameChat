<template>
  <div class="channels">
    <a class="btn btn-outline-dark btn-block channels-name channle-create-button" id="channel-create" data-toggle="modal" data-target="#Modal">channelを作成</a>
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
    <div class="channel-box">
      <p v-for="channel in channels" :key="channel.id">
        <a class="btn btn-outline-dark btn-block channels-name" v-if="channel.name" v-bind:class="{ active: channel.id === currentChannelId }" @click.prevent="fetchComments(channel.id)">{{ channel.name }}</a>
      </p>
    </div>
  </div>
</template>

<script>
export default {
  props:{
    channels:{
      type: Array,
      required: true
    },
    currentChannelId:{
      type: Number
    }
  },
  data: function () {
    return {
      channel:{
        name: '',
      }
    }
  },
  methods:{
    fetchComments(channelId) {
      this.$emit('fetchComments', channelId)
    },
    addChannel(){
      this.$emit('addChannel', this.channel)
      this.channel = {
        name: ''
      };
      $('#Modal').hide()
      $('.modal-backdrop').remove();
    }
  }

}
</script>

<style>

</style>