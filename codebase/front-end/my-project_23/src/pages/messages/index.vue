<template>
  <div>
    <div class="message-container" ref="message">
      <div v-for="m in messages">
        <message v-bind:message="m" @custom-event="userDetail(m.posterId)"></message>
      </div>
    </div>
    <div class="post-container">
      <input class="post-input" v-model="messageInput" placeholder="make a comment">
      <div class="post-action">
        <span v-on:click="addMessage()">submit</span>
      </div>
    </div>
  </div>
</template>

<script>
  import message from '@/components/message'
  export default {
    components: {
      message: message
    },
    data () {
      return {
        user: '',
        receiverId: '',
        messageInput: '',
        messages: [],
        message: {
          posterId: '',
          receiverId: '',
          text: ''
        },
        socketMessager: setInterval(() => {
          this.getMessages()
        }, 500)
      }
    },
    methods: {
      getMessages () {
        let that = this
        wx.request({
          method: 'GET',
          url: 'http://localhost:8080/demo/message/postermessages?id=' + that.receiverId,
          header: { 'content-type': 'application/json' },
          success: async function (res) {
            if (res.statusCode === 200) {
              // that.messages = res.data
              let curMessageIds = new Set(that.messages.filter(m => m.receiverId.toString() === that.user.id.toString() || m.posterId.toString() === that.user.id.toString()).map(m => m.id))
              res.data.filter(m => m.receiverId.toString() === that.user.id.toString() || m.posterId.toString() === that.user.id.toString()).map(m => {
                if (!curMessageIds.has(m.id)) {
                  that.messages.push(m)
                  that.pageScrollToBottom()
                }
              })
            } else {
              // error
              console.log('>>> error getMessages', res.data.error)
            }
          }
        })
      },
      addMessage () {
        if (this.messageInput.trim().length === 0) return
        let that = this
        this.message.posterId = that.user.id
        this.message.receiverId = that.receiverId
        this.message.text = that.messageInput
        wx.request({
          method: 'POST',
          url: 'http://localhost:8080/demo/message/add',
          data: that.message,
          header: { 'content-type': 'application/json' },
          success: async function (res) {
            if (res.statusCode === 200) {
              // success
              if (res.data === 'success') {
                that.clear()
                that.getMessages()
              }
            } else {
              // error
              console.log('>>> error addComment', res.data.error)
            }
          }
        })
      },
      clear () {
        this.messageInput = ''
      },
      userDetail (id) {
        if (id.toString() !== this.user.id.toString()) wx.navigateTo({ url: '/pages/otherProfile/main?id=' + id })
      },
      pageScrollToBottom () {
        console.log('>>> scroll')
        wx.pageScrollTo({
          scrollTop: 9999999,
          duration: 300
        })
      }
    },
    onLoad: function (options) {
      this.user = wx.getStorageSync('user')
      this.receiverId = decodeURIComponent(options.receiverId)
      this.messages = []
    },
    onShow: function (options) {
      this.user = wx.getStorageSync('user')
      this.receiverId = decodeURIComponent(options.receiverId)
      this.messages = []
    }
  }
</script>

<style scoped>
  .message-container {
    padding-bottom: 80px;
  }
  .post-container {
    height: 35px;
    width: 100vw;
    position: fixed;
    bottom: 0;
    background-color: #ffffff;
    display: flex;
    flex-direction: row;
  }
  .post-action {
    margin-left: auto;
  }
</style>
