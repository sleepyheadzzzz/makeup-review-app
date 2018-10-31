<template>
  <div>
    <div class="post-container">
      {{message}}
      <div class="post-head">
        <image class="head-icon" src="/static/images/girl.png"></image>
        <div class="head-content">
          <input class="edit-input" v-model="newUsername">
          <span class="location-inactive">current location</span>
        </div>
        <div class="post-actions">
          <image class="head-icon-action" src="/static/images/logout.png" v-on:click="logout()"></image>
          <image class="head-icon-action" src="/static/images/update.png" v-on:click="update()"></image>
        </div>
      </div>
      <div class="follow-container">
        <span>FOLLOWER: {{follower}}</span>
        <span>FOLLOWING: {{following}}</span>
      </div>
    </div>
    <div class="my-posts">
      <image class="my-post" :src="p.image" v-for="p in posts"></image>
    </div>
  </div>
</template>

<script>
  export default {
    data () {
      return {
        newUsername: '',
        user: '',
        randomImage: 'https://picsum.photos/200/200/?image=' + Math.ceil(Math.random() * 100),
        title: '',
        follower: Math.ceil(Math.random() * 100),
        following: Math.ceil(Math.random() * 2000),
        message: '',
        posts: []
      }
    },
    methods: {
      newImage () {
        this.randomImage = 'https://picsum.photos/200/200/?image=' + Math.ceil(Math.random() * 100)
      },
      clear () {
        this.newImage()
        this.title = ''
      },
      logout () {
        wx.setStorageSync('user', '')
        wx.hideTabBar()
        wx.redirectTo({ url: '/pages/index/main' })
      },
      update () {
        let that = this
        wx.request({
          method: 'PUT',
          url: 'http://localhost:8080/demo/user/update' + '?newUsername=' + this.newUsername,
          data: this.user,
          header: { 'content-type': 'application/json' },
          success: async function (res) {
            if (res.statusCode === 200) {
              // success
              if (res.data.substring(0, 'success'.length) === 'success') {
                that.user.username = that.newUsername
                wx.setStorageSync('user', that.user)
                that.message = ''
              } else {
                // invalid data
                that.message = res.data
              }
            } else {
              // error
              console.log('>>> error login', res.data.error)
            }
          }
        })
      },
      get () {
        let that = this
        wx.request({
          method: 'GET',
          url: 'http://localhost:8080/demo/post/all',
          header: { 'content-type': 'application/json' },
          success: async function (res) {
            if (res.statusCode === 200) {
              that.posts = res.data.reverse()
            } else {
              // error
              console.log('>>> error getPosts', res.data.error)
            }
          }
        })
      }
    },
    created () {
      this.user = wx.getStorageSync('user')
      this.newUsername = this.user.username
      this.get()
    },
    onShow () {
      this.get()
      this.user = wx.getStorageSync('user')
      this.newUsername = this.user.username
      this.message = ''
    }
  }
</script>

<style scoped>
  .post-actions {
    margin-left: auto
  }
  .head-icon-action {
    width: 30px;
    height: 30px;
    margin: 10px;
  }
  .my-post {
    width: 33.33vw;
    height: 33.33vw;
  }
  .edit-input {
    color: #868686;
  }
  .location-inactive {
    color: gainsboro;
  }
  .post-container {
    height: 20vh;
    margin-top: 10px;
    display: flex;
    flex-direction: column;
    justify-content: space-evenly;
  }
  .post-head {
    display: flex;
    flex-direction: row;
  }
  .follow-container {
    margin-left: 10px;
    display: flex;
    flex-direction: row;
    justify-content: space-evenly;
    font-size: 15px;
  }
  .head-content {
    margin-left: 10px;
    display: flex;
    flex-direction: column;
  }
  .head-icon {
    width: 50px;
    height: 50px;
    border-radius: 25px;
  }
  .button-pair {
    margin-right: 10%;
    margin-left: 10%;
    display: flex;
    flex-direction: row;
    justify-content: space-evenly;
  }
  .button-clean {
    display: block;
    background: white;
    color: #ff777f;
    border: 3px solid #ff777f;
    border-radius: 0;
  }
</style>
