<template>
  <div>
    <div v-bind:class="position ? 'post-head-left' : 'post-head-right'">
      <image v-show="!position" class="head-icon" src="/static/images/girl.png" @click="$emit('custom-event')"></image>
      <div class="head-content">
        <span v-bind:class="position ? 'message-self' : 'message-other'">{{messageContent}}</span>
      </div>
      <image v-show="position" class="head-icon" src="/static/images/girl.png" @click="$emit('custom-event')"></image>
    </div>
  </div>
</template>

<script>
export default {
  props: ['message'],
  data () {
    return {
      user: wx.getStorageSync('user'),
      messageContent: this.message.text,
      position: this.message.posterId.toString() === wx.getStorageSync('user').id.toString(),
      posterUsername: '',
      posterLocation: '',
      posterTime: new Date(this.message.timeStamp).toLocaleString()
    }
  },
  methods: {
    getUser () {
      let that = this
      wx.request({
        method: 'GET',
        url: 'http://localhost:8080/demo/user/get?id=' + that.message.posterId,
        header: { 'content-type': 'application/json' },
        success: async function (res) {
          if (res.statusCode === 200) {
            that.posterUsername = res.data.username
          } else {
            // error
            console.log('>>> error getUser', res.data.error)
          }
        }
      })
    }
  },
  created () {
    this.getUser()
  },
  onShow () {
    this.getUser()
  }
}
</script>

<style>
  .post-head-right {
    display: flex;
  }
  .post-head-left {
    display: flex;
    justify-content: flex-end;
  }
  .head-icon {
    width: 50px;
    height: 50px;
    border-radius: 25px;
  }
  .head-content {
    margin-left: 20rpx;
    margin-right: 20rpx;
    display: flex;
    flex-direction: column;
  }
  .message-other {
    padding: 10px 25px 10px 25px;
    border-radius: 25px;
    background-color: #f1f1f1;
    color: black;
  }
  .message-self {
    padding: 10px 25px 10px 25px;
    border-radius: 25px;
    background-color: #5c9951;
    color: white;
  }
</style>
