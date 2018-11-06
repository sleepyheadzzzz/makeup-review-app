<template>
  <div class="post-container">
    {{message}}
    <div class="post-head">
      <image class="head-icon" src="/static/images/girl.png"></image>
      <div class="head-content">
        <span>{{user.username}}</span>
        <span class="location-inactive">current location</span>
      </div>
      <div class="post-actions">
        <image class="head-icon-action" src="/static/images/post.png" v-on:click="add()"></image>
        <image class="head-icon-action" src="/static/images/clear.png" v-on:click="clear()"></image>
      </div>
    </div>
    <br>
    <image class="post-image" :src="post.image" v-on:click="newImage()"></image>
    <textarea class="post-title-input" placeholder="What's on you mind..." v-model="post.title"></textarea>
  </div>
</template>

<script>
  export default {
    data () {
      return {
        user: '',
        message: '',
        post: {
          posterId: '',
          title: '',
          image: '/static/images/plus.png'
        }
      }
    },
    methods: {
      newImage () {
        this.post.image = 'https://picsum.photos/200/200/?image=' + Math.ceil(Math.random() * 100)
      },
      add () {
        let that = this
        this.post.posterId = this.user.id
        wx.request({
          method: 'POST',
          url: 'http://localhost:8080/demo/post/add',
          data: this.post,
          header: { 'content-type': 'application/json' },
          success: async function (res) {
            if (res.statusCode === 200) {
              // success
              if (res.data === 'success') {
                that.clear()
              }
            } else {
              // error
              console.log('>>> error post', res.data.error)
            }
          }
        })
      },
      clear () {
        this.post.image = '/static/images/plus.png'
        this.post.title = ''
      }
    },
    created () {
      this.user = wx.getStorageSync('user')
    },
    onShow () {
      this.user = wx.getStorageSync('user')
      this.message = ''
    }
  }
</script>

<style scoped>
  .post-actions {
    margin-left: auto
  }
  .post-title-input {
    margin: 10px;
  }
  .location-inactive {
    color: gainsboro;
  }
  .post-container {
    margin-top: 10px;
  }
  .post-head {
    display: flex;
    flex-direction: row;
  }
  .post-image {
    object-fit: cover;
    width:100vw;
    height:100vw;
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
  .head-icon-action {
    width: 30px;
    height: 30px;
    margin: 10px;
  }
</style>
